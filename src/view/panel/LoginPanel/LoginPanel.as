package view.panel.LoginPanel
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import view.panel.PanelBase;
	
	public class LoginPanel extends PanelBase
	{
		public var fAccountTxt:TextField;
		public var fPasswordTxt:TextField;
		
		public var fOKBtn:SimpleButton;
		public var fCancelBtn:SimpleButton;
		
		public function LoginPanel()
		{
			super();
			this.init();

		}
		private function init():void
		{
			trace("init")
			this.initUI();
			this.initListener();
		}
		private function initUI():void
		{
			trace("initUI")
			fAccountTxt.text = "test";
			fPasswordTxt.text = "123456";
		}
		private function initListener():void
		{
			trace("initListener")
			fOKBtn.addEventListener(MouseEvent.CLICK,onOKBtnClick);
			fCancelBtn.addEventListener(MouseEvent.CLICK,onCancelBtnClick);
		}
		private function removeListener():void
		{
			fOKBtn.removeEventListener(MouseEvent.CLICK,onOKBtnClick);
			fCancelBtn.removeEventListener(MouseEvent.CLICK,onCancelBtnClick);
		}
		private function dispose():void
		{
			this.removeListener();
		}
		override public function close():void
		{
			this.dispose();
			this.hide();
		}
		private function onOKBtnClick(e:MouseEvent):void
		{
			this.close();
			trace("进入游戏世界！");
		}
		private function onCancelBtnClick(e:MouseEvent):void
		{
			this.close();
		}
	}
}