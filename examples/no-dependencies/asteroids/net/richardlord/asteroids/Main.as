package net.richardlord.asteroids
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width='600', height='450', frameRate='60', backgroundColor='#000000')]

	public class Main extends Sprite
	{
		private var asteroids : Asteroids;
		
		public function Main()
		{
			addEventListener( Event.ENTER_FRAME, init );
		}
		
		private function init( event : Event ) : void
		{
			removeEventListener( Event.ENTER_FRAME, init );
			asteroids = new Asteroids( this, stage.stageWidth, stage.stageHeight );
			asteroids.start();
		}
	}
}
