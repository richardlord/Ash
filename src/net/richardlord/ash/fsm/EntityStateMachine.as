package net.richardlord.ash.fsm
{
	import flash.utils.Dictionary;

	/**
	 * This is a component for a state machine for an entity. The state machine manages a set of states,
	 * each of which has a set of component providers. When the state machine changes the state, it removes
	 * components associated with the previous state and adds components associated with the new state.
	 */
	public class EntityStateMachine
	{
		private var states : Dictionary;
		/**
		 * The current state of the state machine. This is used by the EntityStateMachineSystem.
		 */
		public var currentState : EntityState;
		/**
		 * The state that the state machine is about to switch to. This is used by the EntityStateMachineSystem.
		 */
		public var newState : EntityState;

		/**
		 * Constructor. Creates an EntityStateMachine.
		 */
		public function EntityStateMachine() : void
		{
			states = new Dictionary();
		}

		/**
		 * Add a state to this state machine.
		 * 
		 * @param name The name of this state - used to identify it later in the changeState method call.
		 * @param state The state.
		 * @return This state machine, so methods can be chained.
		 */
		public function addState( name : String, state : EntityState ) : EntityStateMachine
		{
			states[ name ] = state;
			return this;
		}
		
		/**
		 * Create a new state in this state machine.
		 * 
		 * @param name The name of the new state - used to identify it later in the changeState method call.
		 * @return The new EntityState object that is the state. This will need to be configured with
		 * the appropriate component providers.
		 */
		public function createState( name : String ) : EntityState
		{
			var state : EntityState = new EntityState();
			states[ name ] = state;
			return state;
		}

		/**
		 * Change to a new state. The change won't ahppen immediately, it will happen the next time
		 * the EntityStateMachineSystem updates all state machines.
		 * 
		 * @param name The name of the state to change to.
		 */
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
