package net.richardlord.ash.fsm
{
	import flash.utils.Dictionary;

	public class EntityStateMachine
	{
		private var states : Dictionary;
		public var currentState : EntityState;
		public var newState : EntityState;

		public function EntityStateMachine() : void
		{
			states = new Dictionary();
		}

		public function addState( name : String, state : EntityState ) : EntityStateMachine
		{
			states[ name ] = state;
			return this;
		}

		public function changeState( name : String ) : void
		{
			newState = states[ name ];
			if ( !newState )
			{
				throw( new Error( "Entity state " + name + " doesn't exist" ) );
			}
			if( newState == currentState )
			{
				newState = null;
			}
		}
	}
}
