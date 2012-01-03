package net.richardlord.ash.signals
{
	public class ListenerNode
	{
		public var previous : ListenerNode;
		public var next : ListenerNode;
		public var listener : Function;
	}
}
