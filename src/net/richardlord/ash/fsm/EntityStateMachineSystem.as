package net.richardlord.ash.fsm
{
	import net.richardlord.ash.tools.ListIteratingSystem;
	import net.richardlord.ash.core.Entity;

	import flash.utils.Dictionary;

	public class EntityStateMachineSystem extends ListIteratingSystem
	{
		public function EntityStateMachineSystem() : void
		{
			super( EntityStateMachineNode, updateNode );
		}

		public function updateNode( node : EntityStateMachineNode, time : Number ) : void
		{
			if( node.stateMachine.newState )
			{
				var currentState : EntityState = node.stateMachine.currentState;
				var newState : EntityState = node.stateMachine.newState;
				if( newState == currentState )
				{
					newState = null;
					return;
				}
				var entity : Entity = node.entity;
				
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
}
