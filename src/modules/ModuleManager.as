package modules
{
	import flash.utils.Dictionary;

	public class ModuleManager
	{
		private static var _instance:ModuleManager;
		
		private var moduleMap:Dictionary;
		
		public function ModuleManager()
		{
			_instance = this;
			this.init();
		}
		public function begin(cls_:Class,...params:Array):void
		{
			this.getModule(cls_).begin.apply(null,params);
			//this.getModule(cls_).begin(params);
		}
		public function end(cls_:Class):void
		{
			this.getModule(cls_).end();
		}
		public function getModule(cls_:Class):IModule
		{
			if(this.moduleMap[cls_]) return this.moduleMap[cls_] as IModule;
			
			this.moduleMap[cls_] = new cls_();
			return this.moduleMap[cls_] as IModule;
		}
		public function removeModule(cls_:Class):void
		{
			this.getModule(cls_).end();
			this.moduleMap[cls_] = null;
			delete this.moduleMap[cls_];
		}
		private function init():void
		{
			moduleMap = new Dictionary();
		}
		public static function GetInstance():ModuleManager
		{
			if(!_instance) new ModuleManager;
			return _instance;
		}
	}
}