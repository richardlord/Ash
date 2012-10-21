package net.richardlord.ash.fsm
{
	import net.richardlord.ash.core.Entity;

	import flash.utils.Dictionary;

	public class EntityStateMachine
	{
		private var entity : Entity;
		private var states : Dictionary;
		private var currentState : EntityState;
		private var temp : Vector.<*>;
		
		public function EntityStateMachine( entity : Entity ) : void
		{
			this.entity = entity;
			states = new Dictionary();
			temp = new Vector.<*>();
		}
		
		public function addState( name : String, state : EntityState ) : EntityStateMachine
		{
			states[ name ] = state;
			return this;
		}
		
		public function changeState( name : String ) : void
		{
			var newState : EntityState = states[ name ];
			if( !newState )
			{
				throw( new Error( "Entity state " + name + " doesn't exist" ) );
			}
			temp.length = 0;
			var i : int;
			var component : *;
			var toAdd : Vector.<*>;
			if( currentState )
			{
				for( i = 0; i < newState.components.length; ++i )
				{
					temp.push( newState.components[i] );
				}
				for( i = 0; i < currentState.components.length; ++i )
				{
					component = currentState.components[i];
					var j : int = temp.indexOf( component );
					if( j != -1 )
					{
						temp.splice( j, 1 );
					}
					else
					{
						entity.remove( Class( component.constructor ) );
					}
				}
				toAdd = temp;
			}
			else
			{
				toAdd = newState.components;
			}
			for( i = 0; i < toAdd.length; ++i )
			{
				component = toAdd[i];
				entity.add( component );
			}
			currentState = newState;
		}
	}
}
