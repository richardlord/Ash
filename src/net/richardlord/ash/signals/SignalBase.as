package net.richardlord.ash.signals
{
	import flash.utils.Dictionary;

	public class SignalBase
	{
		internal var head : ListenerNode;
		internal var tail : ListenerNode;
		
		private var nodes : Dictionary;

		public function SignalBase()
		{
			nodes = new Dictionary( true );
		}

		public function add( listener : Function ) : void
		{
			var node : ListenerNode;
			for ( node = head; node; node = node.next )
			{
				if( node.listener == listener )
				{
					return;
				}
			}

			node = new ListenerNode();
			node.listener = listener;
			nodes[ listener ] = node;

			if ( !head )
			{
				head = tail = node;
			}
			else
			{
				node.next = head;
				head.previous = node;
				head = node;
			}
		}

		public function remove( listener : Function ) : void
		{
			var node : ListenerNode = nodes[ listener ];
			if ( node )
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
				delete( nodes[ listener ] );
			}
		}
		
		public function removeAll() : void
		{
			while( head )
			{
				var listener : ListenerNode = head;
				head = head.next;
				listener.previous = null;
				listener.next = null;
			}
			tail = null;
		}
	}
}
