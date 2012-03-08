package net.richardlord.ash.tools
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.Node;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;

	/**
	 * A useful class for systems which simply iterate over a set of nodes, performing the same action on each node. This
	 * class removes the need for a lot of boilerplate code in such systems. Extend this class and pass the node type and
	 * a node update method into the constructor. The node update method will be called once per node on the update cycle
	 * with the node instance and the frame time as parameters. e.g.
	 * 
	 * <code>package
	 * {
	 *   class MySystem extends ListIteratingSystem
	 *   {
	 *     public function MySystem()
	 *     {
	 *       super( MyNode, updateNode );
	 *     }
	 *     
	 *     private function updateNode( node : MyNode, time : Number ) : void
	 *     {
	 *       // process the node here
	 *     }
	 *   }
	 * }</code>
	 */
	public class ListIteratingSystem extends System
	{
		protected var nodeList : NodeList;
		protected var nodeClass : Class;
		protected var nodeUpdateFunction : Function;
		
		public function ListIteratingSystem( nodeClass : Class, nodeUpdateFunction : Function )
		{
			this.nodeClass = nodeClass;
			this.nodeUpdateFunction = nodeUpdateFunction;
		}
		
		override public function addToGame( game : Game ) : void
		{
			nodeList = game.getNodeList( nodeClass );
		}
		
		override public function removeFromGame( game : Game ) : void
		{
			nodeList = null;
		}
		
		override public function update( time : Number ) : void
		{
			for( var node : Node = nodeList.head; node; node = node.next )
			{
				nodeUpdateFunction( node, time );
			}
		}
	}
}
