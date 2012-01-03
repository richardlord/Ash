package net.richardlord.ash.tick
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import net.richardlord.ash.signals.Signal1;


	public class FixedTickProvider extends Signal1 implements TickProvider
	{
		private var displayObject : DisplayObject;
		private var frameTime : Number;
		
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
			dispatch( frameTime );
		}
	}
}
