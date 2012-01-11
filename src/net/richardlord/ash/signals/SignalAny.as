/*
 * Based on ideas used in Robert Penner's AS3-signals - https://github.com/robertpenner/as3-signals
 */

package net.richardlord.ash.signals
{
	public class SignalAny extends SignalBase
	{
		protected var classes : Array;

		public function SignalAny( ...classes )
		{
			this.classes = classes;
		}

		public function dispatch( ...objects ) : void
		{
			var node : ListenerNode;
			for ( node = head; node; node = node.next )
			{
				node.listener.apply( null, objects );
			}
		}
	}
}
