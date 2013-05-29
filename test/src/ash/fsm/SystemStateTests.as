package ash.fsm
{
	import ash.core.System;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;

	public class SystemStateTests
	{
		private var state : EngineState;

		[Before]
		public function createState() : void
		{
			state = new EngineState();
		}

		[After]
		public function clearState() : void
		{
			state = null;
		}
		
		[Test]
		public function addInstanceCreatesInstanceProvider() : void
		{
			var component : MockSystem = new MockSystem();
			state.addInstance( component );
			var provider : ISystemProvider = state.providers[0];
			assertThat( provider, instanceOf( SystemInstanceProvider ) );
			assertThat( provider.getSystem(), equalTo( component ) );
		}

        [Test]
        public function addSingletonCreatesSingletonProvider() : void
        {
            state.addSingleton( MockSystem );
            var provider : ISystemProvider = state.providers[0];
            assertThat( provider, instanceOf( SystemSingletonProvider ) );
            assertThat( provider.getSystem(), instanceOf( MockSystem ) );
        }

        [Test]
        public function addMethodCreatesMethodProvider() : void
        {
            const instance:System = new MockSystem();

            const methodProvider:Function = function():System{
                 return instance;
            };

            state.addMethod( methodProvider );
            var provider : ISystemProvider = state.providers[0];
            assertThat( provider, instanceOf( DynamicSystemProvider) );
            assertThat( provider.getSystem(), instanceOf( MockSystem ) );
        }

        [Test]
        public function withPrioritySetsPriorityOnProvider() : void
        {
            var priority:int = 10;
            state.addSingleton( MockSystem ).withPriority( priority );
            var provider : ISystemProvider = state.providers[0];
            assertThat( provider.priority, equalTo( priority ) );

        }
	}
}

import ash.core.System;

class MockSystem extends System
{

}