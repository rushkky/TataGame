package tatagame
{
	import gtool.GTool;

	public class test2
	{
		public function test2()
		{
			GTool.GetInstance().gm.addMsgListener(this,"GMsg",onGMsg);
		}
		private function onGMsg(value1_:String,value2_:int):void
		{
			trace("test2",value1_,value2_);
		}
	}
}