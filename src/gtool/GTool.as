package gtool
{
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import net.GameSocket;
	
	import tatagame.GameStage;

	public class GTool
	{
		private static var _instance:GTool;
		
		public var stage:Stage;
		public var main:Sprite;
		
		public var gd:GData;
		public var gf:GFun;
		public var gm:GMsg;
		public var gp:GPath;
		public var gb:GByte;
		public var gdu:GDepthUtil;
		public var gl:GLoader;
		
		public var socket:GameSocket;
		
		public var gs:GameStage;
		
		public function GTool()
		{
			_instance = this;
			this.init();
		}
		public static function GetInstance():GTool
		{
			if(!_instance) new GTool;
			return _instance;
		}
		private function init():void
		{
			gd = GData.GetInstance();
			gf = GFun.GetInstance();
			gm = GMsg.GetInstance();
			gp = GPath.GetInstance();
			gb = GByte.GetInstance();
			gdu = GDepthUtil.GetInstance();
			gl = GLoader.GetInstance();
			
			socket = GameSocket.GetInstance();
		}
	}
}