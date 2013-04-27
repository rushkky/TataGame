package message
{
	import flash.utils.ByteArray;
	
	public class OPResultMsg implements IMessage
	{
		public static const EVENT_TYPE:String = "2000";
		
		public var resultID:uint;
		public var dwData:uint;
		
		private var _id:uint;
		
		public function OPResultMsg()
		{
			this._id = 2000;
		}
		
		public function get msgID():uint
		{
			return this._id;
		}
		
		public function get msgType():String
		{
			return EVENT_TYPE;
		}
		
		public function encode():ByteArray
		{
			return null;
		}
		
		public function decode(value_:ByteArray):void
		{
			this.resultID = value_.readUnsignedInt();
			this.dwData = value_.readUnsignedInt();
		}
		
		public function init():void
		{
		}
		
		public function toString():void
		{
		}
	}
}