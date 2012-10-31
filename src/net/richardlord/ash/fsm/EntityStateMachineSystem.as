package net.richardlord.ash.fsm
{
	import net.richardlord.ash.tools.ListIteratingSystem;
	import net.richardlord.ash.core.Entity;

	import flash.utils.Dictionary;

	/**
	 * This system updates all EntityStateMachines, checking whether they need to change state
	 * and, if so, performing the state change. If using EntityStateMachines you will need to
	 * add this system to your game. You can have this system run at any time, but I find it is 
	 * usually best just before or just after the render cycle, depending if you want the state 
	 * change to occur before the rendering.
	 */
	public class EntityStateMachineSystem extends ListIteratingSystem
	{
		/**
		 * The constructor.
		 */
		public function EntityStateMachineSystem() : void
		{
			super( EntityStateMachineNode, updateNode );
		}

		/**
		 * Updates the node, checking whether the state needs to change and applying the change
		 * if it is due. It will remove components from the previous state and add components for
		 * the new state.
		 */
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
					entity.add( ComponentProvider( toAdd[ type ] ).getComponent(), type );
				}
				node.stateMachine.currentState = newState;
			}
		}
	}
}
