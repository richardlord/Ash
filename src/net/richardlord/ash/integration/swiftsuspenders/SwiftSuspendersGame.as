package net.richardlord.ash.integration.swiftsuspenders
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;

	import org.swiftsuspenders.Injector;

	/**
	 * @author richard
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
		
		override public function addSystem( system : System ) : void
		{
			injector.injectInto( system );
			super.addSystem( system );
		}
	}
}
