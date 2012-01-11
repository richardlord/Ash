package net.richardlord.ash.core
{
	import net.richardlord.ash.signals.Signal1;
	
	public class NodeList
	{
		public var head : *;
		public var tail : *;
		
		public var nodeAdded : Signal1;
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
