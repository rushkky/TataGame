package tatagame 
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	
	import gtool.GTool;
	
	import message.ClientConnect;
	import message.IMessage;
	import message.OPResultMsg;
	

	public class Main extends Sprite
	{
		private var gt:GTool;
		private var gm:GameManager;
		
		private var importcls:ImportCls;
		
		private var t1:test1 = new test1();
		private var t2:test2 = new test2();
		
		
		
		public function Main()
		{
			if(this.stage == null)
			{
				this.addEventListener(Event.ADDED_TO_STAGE,this.init);
			}
			else
			{
				this.init();
			}
		}
		private function init():void
		{
			initStage();
			
			gt = GTool.GetInstance();
			
			GTool.GetInstance().stage = this.stage;
			GTool.GetInstance().main = this;
			GTool.GetInstance().gs = GameStage.GetInstance();
			
			gm = new GameManager();
			gm.start();
			
//			gt = GTool.GetInstance();
//			//初始化界面
//			gt.stage = this.stage;
//			gt.main = this;
//			gt.gs = GameStage.GetInstance();
//			//加载一开始需要资源
//			this.loadRes();
//			//初始化模块
//			mm = ModuleManager.GetInstance();
			
			
			this.test();
		}
		private function initStage():void
		{
			this.stage.align = flash.display.StageAlign.TOP_LEFT;
			this.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
			this.stage.tabChildren = false;
			this.focusRect = false;
		}
		private function test():void
		{
			gt.gd.put("test",123);
			gt.gd.put("test",32);
			gt.gf.put("MyFun",onMyFun);
			gt.gf.exeFun("MyFun","tata",18,{a:1,b:"2"});
			


			gt.gm.dispatchMsgEvent("GMsg","123",321);
			gt.gm.dispatchMsgEvent("GMsg1","123",321);
			t1.dispose();
			gt.gm.dispatchMsgEvent("GMsg","333",444);
			gt.gm.dispatchMsgEvent("GMsg1","555",555);
			
			gt.gp.version = "1.0.0";
			gt.gp.prepath = "http://www.TataGame.com";
			
			
			connectToServer();
			
			gt.gm.addMsgListener(this,OPResultMsg,onOPResultMsg);
			

		}

		private function onMyFun(value1_:String,value2_:int,value3_:Object):void
		{
			trace(value1_)
			trace(value2_)
			trace(value3_.a,value3_.b)
		}
		private function onOPResultMsg(e:OPResultMsg):void
		{
			trace("Main:OPResultMsg")
			onConnect(null);
			t1.dispose();
			onConnect(null);
		}
		private function connectToServer():void
		{
			gt.socket.addEventListener(Event.CONNECT,onConnect);
			gt.socket.addEventListener(Event.CLOSE,onError);
			gt.socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			gt.socket.addEventListener(IOErrorEvent.IO_ERROR,onError);
			gt.socket.connect("192.168.199.106",5888);
		}
		private function onConnect(e:Event):void
		{
			var msg:ClientConnect = gt.socket.getMsgObject(ClientConnect) as ClientConnect;
			gt.socket.send(msg);
		}
		private function onError(e:Event):void
		{
			switch(e.type)
			{
				case IOErrorEvent.IO_ERROR:
					gt.socket.close();
					break;
				case SecurityErrorEvent.SECURITY_ERROR:
					gt.socket.close();
					break;
				case Event.CLOSE:
					break;
			}
		}
	}
}