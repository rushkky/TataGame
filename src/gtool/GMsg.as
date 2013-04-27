package gtool
{
	import datas.MsgData.MsgData;
	
	import flash.utils.ByteArray;
	
	import message.IMessage;

	public class GMsg
	{
		private static var _instance:GMsg;

		private var arrAddMsg:Array;
		
		public function GMsg()
		{
			_instance = this;
			this.init();
		}
		private function init():void
		{
			this.arrAddMsg = new Array();
		}
		public function addMsgListener(obj_:Object,eventType_:Object,callback_:Function):void
		{
			var md:MsgData = new MsgData();
			md.object = obj_;
			md.eventType = eventType_;
			md.fun = callback_;
			this.arrAddMsg.push(md);
		}
		public function removeMsgListener(obj_:Object,eventType_:Object,callback_:Function):void
		{
			for(var i:int=0;i<this.arrAddMsg.length;++i)
			{
				var md:MsgData = this.arrAddMsg[i] as MsgData;
				if(md.object == obj_ && md.eventType == eventType_ && md.fun == callback_)
				{
					this.arrAddMsg.splice(i,1);
					i--;
				}
			}
		}
		public function removeMsgListenerEx(obj_:Object):void
		{
			for(var i:int=0;i<this.arrAddMsg.length;++i)
			{
				var md:MsgData = this.arrAddMsg[i] as MsgData;
				if(md.object == obj_)
				{
					this.arrAddMsg.splice(i,1);
					i--;
				}
			}
		}
		public function dispatchMsgEvent(eventType_:String,...params_:Array):void
		{
			for(var i:int=0;i<this.arrAddMsg.length;++i)
			{
				var md:MsgData = this.arrAddMsg[i] as MsgData;
				//服务器消息
				if(md.eventType is Class)
				{
					var cls:Class = md.eventType as Class;
					var msg:IMessage = new cls();
					if(msg.msgType == eventType_)
					{
						var data:ByteArray = params_[0] as ByteArray;
						data.position = 0;
						msg.init();
						msg.decode(data);
						md.fun.apply(md.object,[msg]);
					}
				}
				//自定义消息
				else
				{
					if(md.eventType == eventType_)
					{
						md.fun.apply(md.object,params_);
					}
				}
			}
		}
		public function removeAllMsgListener():void
		{
			this.arrAddMsg.splice(0,this.arrAddMsg.length);
		}
		public static function GetInstance():GMsg
		{
			if(!_instance) new GMsg;
			return _instance;
		}
	}
}