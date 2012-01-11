/*
 * Based on ideas used in Robert Penner's AS3-signals - https://github.com/robertpenner/as3-signals
 */

package net.richardlord.ash.signals
{
	public class Signal0 extends SignalBase
	{
		public function Signal0()
		{
		}

		public function dispatch() : void
		{
			var node : ListenerNode;
			for ( node = head; node; node = node.next )
			{
				node.listener();
			}
		}
	}
}
