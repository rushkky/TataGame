package message
{
	import flash.utils.ByteArray;
	
	import gtool.GByte;
	
	public class ClientConnect implements IMessage
	{
		public static const EVENT_TYPE:String = "2052";
		public static const TYPE_NONE:int = 0;
		public static const TYPE_JP:int = 1;
		
		private var _msgID:uint;
		
		public var usVersion:uint;
		public var usAuthType:uint;
		public var usLanguage:uint;
		public var dwData:uint;
		public var params:String;
		
		public function ClientConnect()
		{
			this._msgID = 2052;
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
			
			gb.writeUSHORT(ba,1);
			gb.writeUSHORT(ba,0);
			gb.writeUSHORT(ba,12);
			gb.writeDWORD(ba,6038787);
			gb.writeCHARS(ba,"",6);
			gb.writeUTF(ba,"fuckjp");
			
			return ba;
		}
		
		public function decode(value_:ByteArray):void
		{
		}
		
		public function init():void
		{
		}
		
		public function toString():void
		{
		}
	}
}