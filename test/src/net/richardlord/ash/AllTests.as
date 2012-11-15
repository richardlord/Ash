package net.richardlord.ash
{
	import net.richardlord.ash.core.ComponentMatchingFamilyTests;
	import net.richardlord.ash.core.EntityTests;
	import net.richardlord.ash.core.GameAndFamilyIntegrationTests;
	import net.richardlord.ash.core.GameTests;
	import net.richardlord.ash.core.NodeListTests;
	import net.richardlord.ash.core.SystemTests;
	import net.richardlord.ash.fsm.ComponentInstanceProviderTests;
	import net.richardlord.ash.fsm.ComponentSingletonProviderTests;
	import net.richardlord.ash.fsm.ComponentTypeProviderTests;
	import net.richardlord.ash.fsm.EntityStateMachineTests;
	import net.richardlord.ash.fsm.EntityStateTests;
	import net.richardlord.ash.tools.ComponentPoolTest;
	import net.richardlord.ash.tools.ListIteratingSystemTest;
	import net.richardlord.signals.SignalTest;

	[Suite]
	public class AllTests
	{
		public var entityTests : EntityTests;
		public var nodeListTests : NodeListTests;
		public var systemTests : SystemTests;
		public var gameTests : GameTests;
		public var familyTests : ComponentMatchingFamilyTests;
		public var gameAndFamilyTests : GameAndFamilyIntegrationTests;
		public var signalTests : SignalTest;
		public var componentPoolTest : ComponentPoolTest;
		public var listIteratingSystemTest : ListIteratingSystemTest;
		public var entityStateMachineTests : EntityStateMachineTests;
		public var entityStateTests : EntityStateTests;
		public var componentInstanceProviderTests : ComponentInstanceProviderTests;
		public var componentTypeProviderTests : ComponentTypeProviderTests;
		public var componentSingletonProviderTests : ComponentSingletonProviderTests;
	}
}
