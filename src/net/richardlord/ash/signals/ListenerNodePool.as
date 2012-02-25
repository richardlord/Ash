package net.richardlord.ash.signals
{
	internal class ListenerNodePool
	{
		private var tail : ListenerNode;
		private var cacheTail : ListenerNode;
		
		internal function get():ListenerNode
		{
			if( tail )
			{
				var node : ListenerNode = tail;
				tail = tail.previous;
				node.previous = null;
				return node;
			}
			else
			{
				return new ListenerNode();
			}
		}

		internal function dispose( node : ListenerNode ):void
		{
			node.next = null;
			node.previous = tail;
			tail = node;
		}
		
		internal function cache( node : ListenerNode ) : void
		{
			node.previous = cacheTail;
			cacheTail = node;
		}
		
		internal function releaseCache() : void
		{
			while( cacheTail )
			{
				var node : ListenerNode = cacheTail;
				cacheTail = node.previous;
				node.next = null;
				node.previous = tail;
				tail = node;
			}
		}
	}
}
