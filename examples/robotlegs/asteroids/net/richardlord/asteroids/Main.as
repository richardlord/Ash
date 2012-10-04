package net.richardlord.asteroids
{
	import net.richardlord.ash.integration.robotlegs.AshExtension;
	import net.richardlord.asteroids.events.StartGameEvent;

	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	[SWF(width='600', height='450', frameRate='60', backgroundColor='#000000')]

	public class Main extends Sprite
	{
		public function Main()
		{
			addEventListener( Event.ENTER_FRAME, init );
		}

		private function init( event : Event ) : void
		{
			removeEventListener( Event.ENTER_FRAME, init );
			var context : IContext = ( new Context() )
				.extend( AshExtension )
				.extend( MVCSBundle )
				.configure( this );

			context.injector.map( DisplayObjectContainer );
			context.injector.getInstance( IEventCommandMap );
			var commandMap : IEventCommandMap = context.injector.getInstance( IEventCommandMap );
			commandMap.map( StartGameEvent.START_GAME, StartGameEvent ).toCommand( StartAsteroids );
			var dispatcher : IEventDispatcher = context.injector.getInstance( IEventDispatcher );
			dispatcher.dispatchEvent( new StartGameEvent( this, stage.stageWidth, stage.stageHeight ) );
		}
	}
}
