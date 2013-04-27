package view.panel
{
	public interface IPanel
	{
		function open():void;
		function close():void;
		function show():void;
		function hide():void;
		function setData(data_:Object=null):void;
	}
}