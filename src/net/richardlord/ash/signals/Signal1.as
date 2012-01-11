/*
 * Based on ideas used in Robert Penner's AS3-signals - https://github.com/robertpenner/as3-signals
 */

package net.richardlord.ash.signals
{
	public class Signal1 extends SignalBase
	{
		private var type : Class;

		public function Signal1( type : Class )
		{
			this.type = type;
		}

		public function dispatch( object : * ) : void
		{
			var node : ListenerNode;
			for ( node = head; node; node = node.next )
			{
				node.listener( object );
			}
		}
	}
}
