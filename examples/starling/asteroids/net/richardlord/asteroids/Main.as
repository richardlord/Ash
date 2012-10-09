package net.richardlord.asteroids
{
	import starling.core.Starling;

	import flash.display.Sprite;
	import flash.events.Event;
	
	[SWF(width='600', height='450', frameRate='60', backgroundColor='#000000')]

	public class Main extends Sprite
	{
		private var starling : Starling;
		
		public function Main()
		{
			addEventListener( Event.ENTER_FRAME, init );
		}
		
		private function init( event : Event ) : void
		{
			if( stage.stageWidth && stage.stageHeight )
			{
				removeEventListener( Event.ENTER_FRAME, init );
				starling = new Starling( Asteroids, stage );
				starling.antiAliasing = 0;
				starling.start();
			}
		}
	}
}
