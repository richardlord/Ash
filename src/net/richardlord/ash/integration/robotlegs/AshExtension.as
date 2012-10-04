package net.richardlord.ash.integration.robotlegs
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.integration.swiftsuspenders.SwiftSuspendersGame;

	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IExtension;
	import robotlegs.bender.framework.impl.UID;

	/**
	 * A Robotlegs extension to enable the use of Ash inside a Robotlegs project. This
	 * wraps the SwiftSuspenders integration, passing the Robotlegs context's injector to
	 * the game for injecting into systems.
	 */
	public class AshExtension implements IExtension
	{
		private const _uid : String = UID.create( AshExtension );

		public function extend( context : IContext ) : void
		{
			context.injector.map( Game ).toValue( new SwiftSuspendersGame( context.injector ) );
		}

		public function toString() : String
		{
			return _uid;
		}
	}
}
