package ash.core
{
	import ash.signals.Signal1;
	
	/**
	 * A collection of nodes.
	 * 
	 * <p>Systems within the engine access the components of entities via NodeLists. A NodeList contains
	 * a node for each Entity in the engine that has all the components required by the node. To iterate
	 * over a NodeList, start from the head and step to the next on each loop, until the returned value
	 * is null.</p>
	 * 
	 * <p>for( var node : Node = nodeList.head; node; node = node.next )
	 * {
	 *   // do stuff
	 * }</p>
	 * 
	 * <p>It is safe to remove items from a nodelist during the loop. When a Node is removed form the 
	 * NodeList it's previous and next properties still point to the nodes that were before and after
	 * it in the NodeList just before it was removed.</p>
	 */
	public class NodeList
	{
		/**
		 * The first item in the node list, or null if the list contains no nodes.
		 */
		public var head : *;
		/**
		 * The last item in the node list, or null if the list contains no nodes.
		 */
		public var tail : *;
		
		/**
		 * A signal that is dispatched whenever a node is added to the node list.
		 * 
		 * <p>The signal will pass a single parameter to the listeners - the node that was added.
		 */
		public var nodeAdded : Signal1;
		/**
		 * A signal that is dispatched whenever a node is removed from the node list.
		 * 
		 * <p>The signal will pass a single parameter to the listeners - the node that was removed.
		 */
		public var nodeRemoved : Signal1;
		
		public function NodeList()
		{
			nodeAdded = new Signal1( Node );
			nodeRemoved = new Signal1( Node );
		}
		
		internal function add( node : Node ) : void
		{
			if( ! head )
			{
				head = tail = node;
				node.next = node.previous = null;
			}
			else
			{
				tail.next = node;
				node.previous = tail;
				node.next = null;
				tail = node;
			}
			nodeAdded.dispatch( node );
		}
		
		internal function remove( node : Node ) : void
		{
			if ( head == node)
			{
				head = head.next;
			}
			if ( tail == node)
			{
				tail = tail.previous;
			}
			
			if (node.previous)
			{
				node.previous.next = node.next;
			}
			
			if (node.next)
			{
				node.next.previous = node.previous;
			}
			nodeRemoved.dispatch( node );
			// N.B. Don't set node.next and node.previous to null because that will break the list iteration if node is the current node in the iteration.
		}
		
		internal function removeAll() : void
		{
			while( head )
			{
				var node : Node = head;
				head = node.next;
				node.previous = null;
				node.next = null;
				nodeRemoved.dispatch( node );
			}
			tail = null;
		}
		
		/**
		 * true if the list is empty, false otherwise.
		 */
		public function get empty() : Boolean
		{
			return head == null;
		}
		
		/**
		 * Swaps the positions of two nodes in the list. Useful when sorting a list.
		 */
		public function swap( node1 : Node, node2 : Node ) : void
		{
			if( node1.previous == node2 )
			{
				node1.previous = node2.previous;
				node2.previous = node1;
				node2.next = node1.next;
				node1.next  = node2;
			}
			else if( node2.previous == node1 )
			{
				node2.previous = node1.previous;
				node1.previous = node2;
				node1.next = node2.next;
				node2.next  = node1;
			}
			else
			{
				var temp : Node = node1.previous;
				node1.previous = node2.previous;
				node2.previous = temp;
				temp = node1.next;
				node1.next = node2.next;
				node2.next = temp;
			}
			if( head == node1 )
			{
				head = node2;
			}
			else if( head == node2 )
			{
				head = node1;
			}
			if( tail == node1 )
			{
				tail = node2;
			}
			else if( tail == node2 )
			{
				tail = node1;
			}
			if( node1.previous )
			{							
				node1.previous.next = node1;
			}
			if( node2.previous )
			{
				node2.previous.next = node2;
			}
			if( node1.next )
			{
				node1.next.previous = node1;
			}
			if( node2.next )
			{
				node2.next.previous = node2;
			}
		}
	}
}
