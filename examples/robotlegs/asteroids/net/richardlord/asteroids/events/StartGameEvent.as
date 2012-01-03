package net.richardlord.asteroids.events
{
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class StartGameEvent extends Event
	{
		public static const START_GAME : String = "startGame";
		
		public var container : DisplayObjectContainer;
		public var width : Number;
		public var height : Number;
		
		public function StartGameEvent( container : DisplayObjectContainer, width : Number, height : Number )
		{
			super( START_GAME, false, false );
			this.container = container;
			this.width = width;
			this.height = height;
		}
		
		override public function clone() : Event
		{
			return new StartGameEvent( container, width, height );
		}
	}
}
