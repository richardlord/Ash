package net.richardlord.ash.core
{
	/**
	 * Base class for a node.
	 * 
	 * <p>A node is a set of different components that are required by a system.
	 * A system can request a collection of nodes from the game. Subsequently the Game object creates
	 * a node for every entity that has all of the components in the node class and adds these nodes
	 * to the list obtained by the system. The game keeps the list up to date as entities are added
	 * to and removed from the game and as the components on entities change.</p>
	 */
	public class Node
	{
		/**
		 * The entity whose components are included in the node.
		 */
		public var entity : Entity;
		
		/**
		 * Used by the NodeList class. The previous node in a node list.
		 */
		public var previous : *;
		
		/**
		 * Used by the NodeList class. The next node in a node list.
		 */
		public var next : *;
	}
}
