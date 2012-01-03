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
