package datas.PanelData
{
	import enum.AlignType.AlignType;
	import enum.AlignType.DepthType;
	
	import view.panel.PanelBase;

	public class PanelData
	{
		public var name:String;
		public var info:String;
		public var pos:String;
		public var depth:String;
		public var panel:PanelBase;
		
		public function PanelData()
		{
			
		}
		public function setData(data_:XML):void
		{
			this.name = String(data_.@name);
			this.info = String(data_.@info);
			this.pos = String(data_.@pos)==""?AlignType.MID_MID:String(data_.@pos);
			this.depth = String(data_.@depth)==""?DepthType.MID:String(data_.@depth);
			this.panel = null;
		}
	}
}