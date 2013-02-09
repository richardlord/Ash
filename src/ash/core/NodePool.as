package ash.core
{
	/**
	 * This internal class maintains a pool of deleted nodes for reuse by the framework. This reduces the overhead
	 * from object creation and garbage collection.
	 * 
	 * Because nodes may be deleted from a NodeList while in use, by deleting Nodes from a NodeList
	 * while iterating through the NodeList, the pool also maintains a cache of nodes that are added to the pool
	 * but should not be reused yet. They are then released into the pool by calling the releaseCache method.
	 */
	internal class NodePool
	{
		private var tail : Node;
		private var nodeClass : Class;
		private var cacheTail : Node;

		/**
		 * Creates a pool for the given node class.
		 */
		public function NodePool( nodeClass : Class )
		{
			this.nodeClass = nodeClass;
		}

		/**
		 * Fetches a node from the pool.
		 */
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

		/**
		 * Adds a node to the pool.
		 */
		internal function dispose( node : Node ) : void
		{
			node.next = null;
			node.previous = tail;
			tail = node;
		}
		
		/**
		 * Adds a node to the cache
		 */
		internal function cache( node : Node ) : void
		{
			node.previous = cacheTail;
			cacheTail = node;
		}
		
		/**
		 * Releases all nodes from the cache into the pool
		 */
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
