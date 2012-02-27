package net.richardlord.ash.core
{
	/**
	 * An internal class for a linked list of entities. Used inside the framework for
	 * managing the entities.
	 */
	internal class EntityList
	{
		internal var head : Entity;
		internal var tail : Entity;
		
		internal function add( entity : Entity ) : void
		{
			if( ! head )
			{
				head = tail = entity;
			}
			else
			{
				tail.next = entity;
				entity.previous = tail;
				tail = entity;
			}
		}
		
		internal function remove( entity : Entity ) : void
		{
			if ( head == entity)
			{
				head = head.next;
			}
			if ( tail == entity)
			{
				tail = tail.previous;
			}
			
			if (entity.previous)
			{
				entity.previous.next = entity.next;
			}
			
			if (entity.next)
			{
				entity.next.previous = entity.previous;
			}
		}
		
		internal function removeAll() : void
		{
			while( head )
			{
				var entity : Entity = head;
				head = head.next;
				entity.previous = null;
				entity.next = null;
			}
			tail = null;
		}
	}
}
