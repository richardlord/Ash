package ash
{
	import ash.core.ComponentMatchingFamilyTests;
	import ash.core.EngineAndFamilyIntegrationTests;
	import ash.core.EngineTests;
	import ash.core.EntityTests;
	import ash.core.NodeListTests;
	import ash.core.SystemTests;
	import ash.fsm.ComponentInstanceProviderTests;
	import ash.fsm.ComponentSingletonProviderTests;
	import ash.fsm.ComponentTypeProviderTests;
	import ash.fsm.DynamicComponentProviderTests;
	import ash.fsm.EngineStateMachineTests;
	import ash.fsm.EntityStateMachineTests;
	import ash.fsm.EntityStateTests;
	import ash.fsm.SystemInstanceProviderTests;
	import ash.fsm.SystemMethodProviderTests;
	import ash.fsm.SystemSingletonProviderTests;
	import ash.fsm.SystemStateTests;
	import ash.io.enginecodecs.DecoderTests;
	import ash.io.enginecodecs.EncoderTests;
	import ash.io.enginecodecs.JsonEngineCodecTests;
	import ash.io.objectcodecs.ArrayObjectCodecTests;
	import ash.io.objectcodecs.ClassObjectCodecTests;
	import ash.io.objectcodecs.CodecManagerTests;
	import ash.io.objectcodecs.ObjectReflectionTests;
	import ash.io.objectcodecs.ReflectionObjectCodecTests;
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
		public var objectReflectionTests : ObjectReflectionTests;
		public var reflectionCodecTests : ReflectionObjectCodecTests;
		public var codecManagerTests : CodecManagerTests;
		public var encoderTests : EncoderTests;
		public var decoderTests : DecoderTests;
		public var jsonEngineCodecTests : JsonEngineCodecTests;
		public var arrayObjectCodecTests : ArrayObjectCodecTests;
		public var classObjectCodecTests : ClassObjectCodecTests;
	}
}
