package ash.fsm
{
import ash.core.System;
import ash.fsm.ISystemProvider;

import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;

	public class SystemStateTests
	{
		private var state : SystemState;

		[Before]
		public function createState() : void
		{
			state = new SystemState();
		}

		[After]
		public function clearState() : void
		{
			state = null;
		}
		
		[Test]
		public function addWithNoQualifierCreatesSingletonProvider() : void
		{
			state.add( MockSystem );
			var provider : ISystemProvider = state.providers[MockSystem];
			assertThat( provider, instanceOf( SystemSingletonProvider ) );
			assertThat( provider.getSystem(), instanceOf( MockSystem ) );
		}

		[Test]
		public function addWithInstanceQualifierCreatesInstanceProvider() : void
		{
			var component : MockSystem = new MockSystem();
			state.add( MockSystem ).withInstance( component );
			var provider : ISystemProvider = state.providers[MockSystem];
			assertThat( provider, instanceOf( SystemInstanceProvider ) );
			assertThat( provider.getSystem(), equalTo( component ) );
		}

        [Test]
        public function addWithSingletonQualifierCreatesSingletonProvider() : void
        {
            state.add( MockSystem ).withSingleton( MockSystem );
            var provider : ISystemProvider = state.providers[MockSystem];
            assertThat( provider, instanceOf( SystemSingletonProvider ) );
            assertThat( provider.getSystem(), instanceOf( MockSystem ) );
        }

        [Test]
        public function addWithMethodQualifierCreatesMethodProvider() : void
        {
            const instance:System = new MockSystem();

            const methodProvider:Function = function():System{
                 return instance;
            }

            state.add( MockSystem ).withMethod( methodProvider );
            var provider : ISystemProvider = state.providers[MockSystem];
            assertThat( provider, instanceOf( DynamicSystemProvider) );
            assertThat( provider.getSystem(), instanceOf( MockSystem ) );
        }

        [Test]
        public function withPriorityCalledLastSetsPriorityOnProvider() : void
        {
            var priority:int = 10;
            state.add( MockSystem ).withSingleton( MockSystem ).withPriority( priority );
            var provider : ISystemProvider = state.providers[MockSystem];
            assertThat( provider.priority, equalTo( priority ) );

        }

        [Test]
        public function withPriorityCalledFirstSetsPriorityOnProvider() : void
        {
            var priority:int = 10;
            state.add( MockSystem ).withPriority( priority ).withSingleton( MockSystem );
            var provider : ISystemProvider = state.providers[MockSystem];
            assertThat( provider.priority, equalTo( priority ) );

        }
	}
}

import ash.core.System;

class MockSystem extends System
{

}

class MockSystem2 extends System
{
	
}