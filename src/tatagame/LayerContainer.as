package tatagame
{
	import flash.display.Sprite;
	
	public class LayerContainer extends Sprite
	{
		private static var _instance:LayerContainer;
		
		public var msgContainer:Sprite;
		public var uiContainer:Sprite;
		public var battleContainer:Sprite;
		public var mapContainer:Sprite;

		public function LayerContainer()
		{
			super();
			
			this.msgContainer = new Sprite();
			this.uiContainer = new Sprite();
			this.battleContainer = new Sprite();
			this.mapContainer = new Sprite();
			
			addChild(this.mapContainer);
			addChild(this.battleContainer);
			addChild(this.uiContainer);
			addChild(this.msgContainer);
			
			_instance = this;
		}
		public static function GetInstance():LayerContainer
		{
			if(!_instance) new LayerContainer();
			return _instance;
		}
	}
}