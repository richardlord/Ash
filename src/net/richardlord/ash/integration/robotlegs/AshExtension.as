package net.richardlord.ash.integration.robotlegs
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.integration.swiftsuspenders.SwiftSuspendersGame;

	import robotlegs.bender.core.api.IContext;
	import robotlegs.bender.core.api.IContextExtension;

	/**
	 * A Robotlegs extension to enable the use of Ash inside a Robotlegs project. This
	 * wraps the SwiftSuspenders integration, passing the Robotlegs context's injector to
	 * the game for injecting into systems.
	 */
	public class AshExtension implements IContextExtension
	{
		private var context : IContext;

		public function install( context : IContext ) : void
		{
			this.context = context;
			context.injector.map( Game ).toValue( new SwiftSuspendersGame( context.injector ) );
		}

		public function initialize() : void
		{
		}

		public function uninstall() : void
		{
			context.injector.unmap( Game );
		}
	}
}
