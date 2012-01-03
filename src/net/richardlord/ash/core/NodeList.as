package net.richardlord.ash.core
{
	
	public class NodeList
	{
		public var head : *;
		public var tail : *;
		
		public function add( node : Node ) : void
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
		}
		
		public function remove( node : Node ) : void
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
		}
		
		public function get empty() : Boolean
		{
			return head == null;
		}
	}
}
