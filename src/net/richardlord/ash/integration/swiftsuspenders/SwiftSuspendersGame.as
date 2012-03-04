package net.richardlord.ash.integration.swiftsuspenders
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;

	import org.swiftsuspenders.Injector;

	/**
	 * A custom game class for games that use SwiftSuspenders for dependency injection.
	 * Pass a SwiftSuspenders injector to the constructor, and the game will automatically
	 * apply injection rules to the systems when they are added to the game.
	 */
	public class SwiftSuspendersGame extends Game
	{
		protected var injector : Injector;
		
		public function SwiftSuspendersGame( injector : Injector )
		{
			super();
			this.injector = injector;
			injector.map( NodeList ).toProvider( new NodeListProvider( this ) );
		}
		
		override public function addSystem( system : System, priority : int ) : void
		{
			injector.injectInto( system );
			super.addSystem( system, priority );
		}
	}
}
