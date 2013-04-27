package gtool
{
	import flash.utils.Dictionary;

	public class GFun
	{
		private static var _instance:GFun;
		private var map:Dictionary;
		public function GFun()
		{
			_instance = this;
			this.init();	
		}
		private function init():void
		{
			this.map = new Dictionary();	
		}
		public function put(keyName_:String,fun_:Function):void
		{
			this.map[keyName_] = fun_;
		}
		public function exeFun(keyName_:String,...parames_:Array):Object
		{
			var fun:Function = this.map[keyName_];
			if(fun==null) return null;
			return fun.apply(null,parames_);
		}
		public function removeFun(keyName_:String):void
		{
			this.map[keyName_] = null;
			delete this.map[keyName_];
		}
		public function removeAllFun():void
		{
			for(var keyName:String in this.map)
			{
				delete this.map[keyName];
			}
		}
		public static function GetInstance():GFun
		{
			if(!_instance) new GFun;
			return _instance;
		}
	}
}