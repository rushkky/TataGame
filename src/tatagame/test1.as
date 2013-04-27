package tatagame
{
	import gtool.GTool;
	
	import message.OPResultMsg;

	public class test1
	{
		public function test1()
		{
			GTool.GetInstance().gm.addMsgListener(this,"GMsg",onGMsg);
			GTool.GetInstance().gm.addMsgListener(this,"GMsg1",onGMsg1);
			GTool.GetInstance().gm.addMsgListener(this,OPResultMsg,onOPResultMsg);
		}
		private function onGMsg(value1_:String,value2_:int):void
		{
			trace("test1",value1_,value2_);
		}
		private function onGMsg1(value1_:String,value2_:int):void
		{
			trace("test11",value1_,value2_);
		}
		public function dispose():void
		{
			//GTool.GetInstance().gm.removeMsgListenerEx(this);
			GTool.GetInstance().gm.removeMsgListener(this,"GMsg1",onGMsg);
		}
		private function onOPResultMsg(e:OPResultMsg):void
		{
			trace("test1:OPResultMsg")
		}
		
	}
}