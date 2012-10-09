package net.richardlord.ash.integration.starling
{
	import net.richardlord.ash.tick.TickProvider;
	import net.richardlord.signals.Signal1;
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;


	/**
	 * Provides a frame tick with a fixed frame duration. This tick ignores the length of
	 * the frame and dispatches the same time period for each tick.
	 */
	public class StarlingFixedTickProvider extends Signal1 implements TickProvider, IAnimatable
	{
		private var juggler : Juggler;
		private var frameTime : Number;
		
		/**
		 * Applies a time adjustement factor to the tick, so you can slow down or speed up the entire game.
		 * The update tick time is multiplied by this value, so a value of 1 will run the game at the normal rate.
		 */
		public var timeAdjustment : Number = 1;
		
		public function StarlingFixedTickProvider( juggler : Juggler, frameTime : Number )
		{
			super( Number );
			this.juggler = juggler;
			this.frameTime = frameTime;
		}
		
		public function start() : void
		{
			juggler.add( this );
		}
		
		public function stop() : void
		{
			juggler.remove( this );
		}
		
		public function advanceTime( frameTime : Number ) : void
		{
			dispatch( frameTime * timeAdjustment );
		}
	}
}
