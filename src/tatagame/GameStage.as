package tatagame
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	
	import gtool.GTool;

	public class GameStage
	{
		public var stage:Stage;
		public var main:Sprite;
		public var lc:LayerContainer;
		
		public var StageWidth:int = 1600;
		public var StageHeight:int = 800;
		
		private var canvers:Shape;
		
//		private var test:Shape
		
		private static var _instance:GameStage;
		
		public function GameStage()
		{
			_instance = this;
			this.init();
			this.initListener();
		}
		private function init():void
		{
			this.stage = GTool.GetInstance().stage;
			this.main = GTool.GetInstance().main;
			
			canvers = new Shape();
			this.main.addChild(canvers);
			
			this.lc = LayerContainer.GetInstance();
			this.stage.addChild(lc);
				

//			test = new Shape();
//			this.main.addChild(test);
			
			//GTool.GetInstance().gdu.swapDepth(this.main,canvers);
		}
		private function drawCanvers():void
		{
			canvers.graphics.clear();
			canvers.graphics.beginFill(0x666666);
			canvers.graphics.drawRect(0,0,this.stage.stageWidth,this.stage.stageHeight);
			canvers.graphics.endFill();
			
//			test.graphics.clear();
//			test.graphics.beginFill(0xff0000);
//			test.graphics.drawRect(0,0,400,200);
//			test.graphics.endFill();
//			
//			
//			test.x = (this.stage.stageWidth - 400)/2;
//			test.y = (this.stage.stageHeight - 200)/2;

		}
		private function initListener():void
		{
			this.stage.addEventListener(Event.RESIZE,this.resizeHandle);
			resizeHandle(null);
		}
		private function resizeHandle(e:Event):void
		{
			drawCanvers();
		}
		public static function GetInstance():GameStage
		{
			if(!_instance) new GameStage();
			return _instance;
		}
	}
}