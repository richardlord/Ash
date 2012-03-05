package net.richardlord.ash.tick
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import net.richardlord.ash.signals.Signal1;

	/**
	 * Provides a frame tick with a fixed frame duration. This tick ignores the length of
	 * the frame and dispatches the same time period for each tick.
	 */
	public class FixedTickProvider extends Signal1 implements TickProvider
	{
		private var displayObject : DisplayObject;
		private var frameTime : Number;
		
		/**
		 * Applies a time adjustement factor to the tick, so you can slow down or speed up the entire game.
		 * The update tick time is multiplied by this value, so a value of 1 will run the game at the normal rate.
		 */
		public var timeAdjustment : Number = 1;
		
		public function FixedTickProvider( displayObject : DisplayObject, frameTime : Number )
		{
			super( Number );
			this.displayObject = displayObject;
			this.frameTime = frameTime;
		}
		
		public function start() : void
		{
			displayObject.addEventListener( Event.ENTER_FRAME, dispatchTick );
		}
		
		public function stop() : void
		{
			displayObject.removeEventListener( Event.ENTER_FRAME, dispatchTick );
		}
		
		private function dispatchTick( event : Event ) : void
		{
			dispatch( frameTime * timeAdjustment );
		}
	}
}
