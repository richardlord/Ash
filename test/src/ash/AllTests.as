package ash
{
	import ash.core.ComponentMatchingFamilyTests;
	import ash.core.EngineTests;
	import ash.core.EngineAndFamilyIntegrationTests;
	import ash.core.EntityTests;
	import ash.core.NodeListTests;
	import ash.core.SystemTests;
	import ash.fsm.ComponentInstanceProviderTests;
	import ash.fsm.ComponentSingletonProviderTests;
	import ash.fsm.ComponentTypeProviderTests;
	import ash.fsm.DynamicComponentProviderTests;
	import ash.fsm.EntityStateMachineTests;
	import ash.fsm.EntityStateTests;
	import ash.fsm.SystemInstanceProviderTests;
	import ash.fsm.SystemMethodProviderTests;
	import ash.fsm.SystemSingletonProviderTests;
	import ash.fsm.EngineStateMachineTests;
	import ash.fsm.SystemStateTests;
	import ash.signals.SignalTest;
	import ash.tools.ComponentPoolTest;
	import ash.tools.ListIteratingSystemTest;

	[Suite]
	public class AllTests
	{
		public var entityTests : EntityTests;
		public var nodeListTests : NodeListTests;
		public var systemTests : SystemTests;
		public var engineTests : EngineTests;
		public var familyTests : ComponentMatchingFamilyTests;
		public var engineAndFamilyTests : EngineAndFamilyIntegrationTests;
		public var signalTests : SignalTest;
		public var componentPoolTest : ComponentPoolTest;
		public var listIteratingSystemTest : ListIteratingSystemTest;
		public var entityStateMachineTests : EntityStateMachineTests;
		public var entityStateTests : EntityStateTests;
		public var componentInstanceProviderTests : ComponentInstanceProviderTests;
		public var componentTypeProviderTests : ComponentTypeProviderTests;
		public var componentSingletonProviderTests : ComponentSingletonProviderTests;
		public var dynamicComponentProviderTests : DynamicComponentProviderTests;
		public var systemInstanceProviderTests : SystemInstanceProviderTests;
		public var systemSingletonProviderTests : SystemSingletonProviderTests;
		public var systemMethodProviderTests : SystemMethodProviderTests;
		public var systemStateTests : SystemStateTests;
		public var systemStateMachineTests : EngineStateMachineTests;
	}
}
