package modules
{
	import datas.PanelData.PanelData;
	
	import enum.AlignType.DepthType;
	import enum.ResType.ResType;
	
	import flash.display.Sprite;
	
	import gtool.GTool;
	
	import tatagame.LayerContainer;
	
	import view.panel.PanelBase;
	import view.panel.PanelManager;

	public class UIModule implements IModule
	{
		private static var _instance:UIModule;
		
		private var topContainer:Sprite;
		private var midContainer:Sprite;
		private var bottomContainer:Sprite;
		
		private var lc:LayerContainer;
		private var pm:PanelManager;
		
		private var gt:GTool;
		
		public function UIModule()
		{
			_instance = this;
			this.init();
			this.initListener();
		}
		private function init():void
		{
			lc = LayerContainer.GetInstance();
			pm = PanelManager.GetInstance();
			gt = GTool.GetInstance();
			
			topContainer = new Sprite();
			midContainer = new Sprite();
			bottomContainer = new Sprite();
			lc.uiContainer.addChild(bottomContainer);
			lc.uiContainer.addChild(midContainer);
			lc.uiContainer.addChild(topContainer);
		}
		private function initListener():void
		{
			
		}
		public function begin(...params:Array):void
		{
			var fun:Function = params[0] as Function;
			pm.loadLoadPanel(fun);
		}
		public function showPanel(name_:String,callback_:Function=null,data_:Object=null):void
		{
			this.pm.load(name_,callback_,data_);
		}
		public function closePanel(name_:String):void
		{
			this.pm.close([name_]);
		}
		public function end():void
		{
		}
		public function addToStage(pd_:PanelData):void
		{
			switch(pd_.depth)
			{
				case DepthType.BOTTOM:
					bottomContainer.addChild(pd_.panel);
					break;
				case DepthType.MID:
					midContainer.addChild(pd_.panel);
					break;
				case DepthType.TOP:
					topContainer.addChild(pd_.panel);
					break;
						
			}
		}
		public static function GetInstance():UIModule
		{
			if(!_instance) new UIModule();
			return _instance;
		}
	}
}