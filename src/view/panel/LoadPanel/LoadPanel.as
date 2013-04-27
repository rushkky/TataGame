package view.panel.LoadPanel
{
	import datas.LoadData.LoadData;
	
	import enum.EventType.EventType;
	import enum.EventType.MyEvent;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.text.TextField;
	
	import gtool.GLoader;
	import gtool.GTool;
	
	import view.panel.PanelBase;
	
	public class LoadPanel extends PanelBase
	{
		public var fInfoTxt:TextField;
		private var gl:GLoader;
		
		public function LoadPanel()
		{
			super();
			this.init();
			this.initListener();
		}
		private function init():void
		{
			gl = GTool.GetInstance().gl;
			fInfoTxt.text = "";
		}
		private function initListener():void
		{
			gl.addEventListener(EventType.RES_PROGRESS,onResPrograss);
			gl.addEventListener(EventType.RES_ALLLOAD,onResAllLoad);
		}
		private function onResPrograss(e:MyEvent):void
		{
			this.show()
			var ld:LoadData = e.value[0];
			var event:ProgressEvent = e.value[1];
			fInfoTxt.text = "正在加载"+ld.url+"......("+event.bytesLoaded+"/"+event.bytesTotal+")";
			trace(fInfoTxt.text)
		}
		private function onResAllLoad(e:MyEvent):void
		{
			this.hide()
		}
	}
}