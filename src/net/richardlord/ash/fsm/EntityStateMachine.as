package net.richardlord.ash.fsm
{
	import net.richardlord.ash.core.Entity;

	import flash.utils.Dictionary;

	public class EntityStateMachine
	{
		private var entity : Entity;
		private var states : Dictionary;
		private var currentState : EntityState;

		public function EntityStateMachine( entity : Entity ) : void
		{
			this.entity = entity;
			states = new Dictionary();
		}

		public function addState( name : String, state : EntityState ) : EntityStateMachine
		{
			states[ name ] = state;
			return this;
		}

		public function changeState( name : String ) : void
		{
			var newState : EntityState = states[ name ];
			if ( !newState )
			{
				throw( new Error( "Entity state " + name + " doesn't exist" ) );
			}
			var toAdd : Dictionary;
			var type : Class;
			var t : *;
			if ( currentState )
			{
				toAdd = new Dictionary();
				for( t in newState.providers )
				{
					type = Class( t );
					toAdd[ type ] = newState.providers[ type ];
				}
				for( t in currentState.providers )
				{
					type = Class( t );
					var other : ComponentProvider = toAdd[ type ];

					if ( other && other.identifier == currentState.providers[ type ].identifier )
					{
						delete toAdd[ type ];
					}
					else
					{
						entity.remove( type );
					}
				}
			}
			else
			{
				toAdd = newState.providers;
			}
			for( t in toAdd )
			{
				type = Class( t );
				entity.add( toAdd[ type ].component, type );
			}
			currentState = newState;
		}
	}
}
