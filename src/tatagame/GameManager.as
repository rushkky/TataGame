package tatagame
{
	import enum.EventType.EventType;
	import enum.EventType.MyEvent;
	import enum.ResType.ResType;
	
	import gtool.GTool;
	
	import modules.ModuleManager;
	import modules.UIModule;
	
	import view.panel.PanelManager;

	public class GameManager
	{
		private var gt:GTool;
		private var mm:ModuleManager;
		private var pm:PanelManager;
		
		public function GameManager()
		{
			this.init();
			this.initListener();
		}
		private function init():void
		{
			gt = GTool.GetInstance();
			mm = ModuleManager.GetInstance();
			pm = PanelManager.GetInstance();
		}
		private function initListener():void
		{
			gt.gm.addMsgListener(this,EventType.RES_ALLLOAD,onResAllLoad);
		}
		public function start():void
		{	
			mm.begin(UIModule,this.uiModuleReady);	
		}
		private function uiModuleReady():void
		{
			this.loadRes();
		}
		private function loadRes():void
		{
			gt.gl.load("/config/PanelConfig.xml",ResType.TEXT,"PanelConfig");
			gt.gl.load("/config/CardConfig.xml",ResType.TEXT,"CardConfig");
			gt.gl.load("/config/SkillConfig.xml",ResType.TEXT,"SkillConfig");
		}
		private function onResAllLoad():void
		{
			gt.gm.removeMsgListener(this,EventType.RES_ALLLOAD,onResAllLoad);
			//开始显示界面，显示地图
			var panelXML:XML = gt.gl.getRes("PanelConfig") as XML;
			pm.init(panelXML);
			
			var um:UIModule = mm.getModule(UIModule) as UIModule;
			if(um)
			{
				um.showPanel("LoginPanel");
			}
		}
	}
}