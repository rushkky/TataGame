package message
{
	import flash.utils.ByteArray;
	
	import gtool.GByte;
	
	public class LoginMsg implements IMessage
	{
		public static const EVENT_TYPE:String = "1000";
		
		public var accountID:uint;
		public var password:String;
		public var resultID:uint;
		
		private var _msgID:uint;
		
		public function LoginMsg()
		{
		}
		
		public function get msgID():uint
		{
			return this._msgID;
		}
		
		public function get msgType():String
		{
			return EVENT_TYPE;
		}
		
		public function encode():ByteArray
		{
			var gb:GByte = GByte.GetInstance();
			var ba:ByteArray = GByte.GetTempBA();
			
			gb.writeOBJID(ba,this.accountID);
			gb.writeCHARS((ba,this.password,32);
			gb.writeOBJID(ba,this.resultID);
			
			return ba;
		}
		
		public function decode(value_:ByteArray):void
		{
			var gb:GByte = GByte.GetInstance();
			
			this.accountID = gb.readOBJID(value_);
			this.password = gb.readCHARS(value_,32);
			this.resultID = gb.readOBJID(value_);
		}
		
		public function init():void
		{
		}
		
		public function toString():void
		{
		}
	}
}