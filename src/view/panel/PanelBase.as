package view.panel
{
	import enum.AlignType.AlignType;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import gtool.GTool;
	
	public class PanelBase extends Sprite implements IPanel
	{
		public var alignType:String;
		private var gt:GTool;
			
		public function PanelBase()
		{
			super();
			alignType = AlignType.MID_MID;
			
			this.init();
			this.initListener();
		}
		private function init():void
		{
			gt = GTool.GetInstance();
		}
		private function initListener():void
		{
			gt.stage.addEventListener(Event.RESIZE,onResize);			
			onResize(null);
		}
		private function onResize(e:Event):void
		{
			switch(alignType)
			{
				case AlignType.MID_MID:
					this.x = (this.gt.stage.stageWidth - this.width)/2;
					this.y = (this.gt.stage.stageHeight - this.height)/2;
					break;
			}
		}
		public function show():void
		{
			this.visible = true;	
		}
		public function hide():void
		{
			this.visible = false;
		}
		public function open():void
		{
		}
		
		public function close():void
		{
		}
		
		public function setData(data_:Object=null):void
		{
		}
		
	}
}