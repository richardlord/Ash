package net.richardlord.ash.fsm
{
	import net.richardlord.ash.core.Node;

	/**
	 * The node used by the EntityStateMachineSystem to find all the EntityStateMachines and update them.
	 */
	public class EntityStateMachineNode extends Node
	{
		public var stateMachine : EntityStateMachine;
	}
}
