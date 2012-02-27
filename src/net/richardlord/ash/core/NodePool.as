package net.richardlord.ash.core
{
	/**
	 * This internal class maintains a pool of deleted nodes for reuse by framework. This reduces the overhead
	 * from object creation and garbage collection.
	 */
	internal class NodePool
	{
		private var tail : Node;
		private var nodeClass : Class;
		private var cacheTail : Node;

		public function NodePool( nodeClass : Class )
		{
			this.nodeClass = nodeClass;
		}

		internal function get() : Node
		{
			if ( tail )
			{
				var node : Node = tail;
				tail = tail.previous;
				node.previous = null;
				return node;
			}
			else
			{
				return new nodeClass();
			}
		}

		internal function dispose( node : Node ) : void
		{
			node.next = null;
			node.previous = tail;
			tail = node;
		}
		
		internal function cache( node : Node ) : void
		{
			node.previous = cacheTail;
			cacheTail = node;
		}
		
		internal function releaseCache() : void
		{
			while( cacheTail )
			{
				var node : Node = cacheTail;
				cacheTail = node.previous;
				node.next = null;
				node.previous = tail;
				tail = node;
			}
		}
	}
}
