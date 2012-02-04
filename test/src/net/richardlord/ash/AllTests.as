package net.richardlord.ash
{
	import net.richardlord.ash.core.EntityTests;
	import net.richardlord.ash.core.FamilyTests;
	import net.richardlord.ash.core.NodeListTests;
	import net.richardlord.ash.core.SystemTests;
	import net.richardlord.ash.signals.SignalTest;

	[Suite]
	public class AllTests
	{
		public var entityTests : EntityTests;
		public var nodeListTests : NodeListTests;
		public var systemTests : SystemTests;
		public var familyTests : FamilyTests;
		public var signalTests : SignalTest;
	}
}
