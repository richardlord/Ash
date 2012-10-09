package net.richardlord.ash.integration.starling
{
	import net.richardlord.ash.tick.TickProvider;
	import net.richardlord.signals.Signal1;
	import starling.animation.IAnimatable;
	import starling.animation.Juggler;


	/**
	 * Provides a frame tick where the frame duration is the time since the previous frame.
	 * There is a maximum frame time parameter in the constructor that can be used to limit
	 * the longest period a frame can be.
	 */
	public class StarlingFrameTickProvider extends Signal1 implements TickProvider, IAnimatable
	{
		private var juggler : Juggler;
		private var maximumFrameTime : Number;
		
		/**
		 * Applies a time adjustement factor to the tick, so you can slow down or speed up the entire game.
		 * The update tick time is multiplied by this value, so a value of 1 will run the game at the normal rate.
		 */
		public var timeAdjustment : Number = 1;
		
		public function StarlingFrameTickProvider( juggler : Juggler, maximumFrameTime : Number = Number.MAX_VALUE )
		{
			super( Number );
			this.juggler = juggler;
			this.maximumFrameTime = maximumFrameTime;
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
			if( frameTime > maximumFrameTime )
			{
				frameTime = maximumFrameTime;
			}
			dispatch( frameTime * timeAdjustment );
		}
	}
}
