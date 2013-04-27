package gtool
{
	public class GPath
	{
		public var version:String;
	 	public var prepath:String;
		
		private static var _instance:GPath;
		
		public function GPath()
		{
			_instance = this;
			this.init();
		}
		private function init():void
		{
			
		}
		public static function GetInstance():GPath
		{
			if(!_instance) new GPath;
			return _instance;
		}
	}
}