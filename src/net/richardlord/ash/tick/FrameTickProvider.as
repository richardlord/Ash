package net.richardlord.ash.tick
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.getTimer;
	import net.richardlord.ash.signals.Signal1;


	public class FrameTickProvider extends Signal1 implements TickProvider
	{
		private var displayObject : DisplayObject;
		private var previousTime : Number;
		private var maximumFrameTime : Number = 0.05;
		
		public function FrameTickProvider( displayObject : DisplayObject, maximumFrameTime : Number = Number.MAX_VALUE )
		{
			super( Number );
			this.displayObject = displayObject;
			this.maximumFrameTime = maximumFrameTime;
		}
		
		public function start() : void
		{
			previousTime = getTimer();
			displayObject.addEventListener( Event.ENTER_FRAME, dispatchTick );
		}
		
		public function stop() : void
		{
			displayObject.removeEventListener( Event.ENTER_FRAME, dispatchTick );
		}
		
		private function dispatchTick( event : Event ) : void
		{
			var temp : Number = previousTime;
			previousTime = getTimer();
			var frameTime : Number = ( previousTime - temp ) / 1000;
			if( frameTime > maximumFrameTime )
			{
				frameTime = maximumFrameTime;
			}
			dispatch( frameTime );
		}
	}
}
