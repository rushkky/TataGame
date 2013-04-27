package enum.EventType
{
	import flash.events.Event;
	
	public class MyEvent extends Event
	{
		public var key:String;
		public var value:Object;
		
		
		public function MyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}