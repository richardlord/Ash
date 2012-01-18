package net.richardlord.ash.core
{
	import net.richardlord.ash.signals.Signal1;
	
	/**
	 * A collection of nodes.
	 * 
	 * <p>Systems within the game access the components of entities via NodeLists. A NodeList contains
	 * a node for each Entity in the game that has all the components required by the node. To iterate
	 * over a NodeList, start from the head and step to the next on each loop, until the returned value
	 * is null.</p>
	 * 
	 * <p>for( var node : Node = nodeList.head; node; node = node.next )
	 * {
	 *   // do stuff
	 * }</p>
	 * 
	 * <p>It is safe to remove items from a nodelist during the loop.</p>
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
			}
			else
			{
				tail.next = node;
				node.previous = tail;
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
		
		public function get empty() : Boolean
		{
			return head == null;
		}
	}
}
