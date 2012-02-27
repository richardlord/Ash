package net.richardlord.ash.core
{
	/**
	 * Used internally, this is an ordered list of Systems for use by the game loop.
	 */
	internal class SystemList
	{
		internal var head : System;
		internal var tail : System;
		
		internal function add( system : System ) : void
		{
			if( ! head )
			{
				head = tail = system;
			}
			else
			{
				for( var node : System = tail; node; node = node.previous )
				{
					if( node.priority <= system.priority )
					{
						break;
					}
				}
				if( node == tail )
				{
					tail.next = system;
					system.previous = tail;
					tail = system;
				}
				else if( !node )
				{
					system.next = head;
					head.previous = system;
					head = system;
				}
				else
				{
					system.next = node.next;
					system.previous = node;
					node.next.previous = system;
					node.next = system;
				}
			}
		}
		
		internal function remove( system : System ) : void
		{
			if ( head == system)
			{
				head = head.next;
			}
			if ( tail == system)
			{
				tail = tail.previous;
			}
			
			if (system.previous)
			{
				system.previous.next = system.next;
			}
			
			if (system.next)
			{
				system.next.previous = system.previous;
			}
		}
		
		internal function removeAll() : void
		{
			while( head )
			{
				var system : System = head;
				head = head.next;
				system.previous = null;
				system.next = null;
			}
			tail = null;
		}
	}
}
