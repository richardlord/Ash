package ash.fsm
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;

	public class EntityStateTests
	{
		private var state : EntityState;

		[Before]
		public function createState() : void
		{
			state = new EntityState();
		}

		[After]
		public function clearState() : void
		{
			state = null;
		}
		
		[Test]
		public function addWithNoQualifierCreatesTypeProvider() : void
		{
			state.add( MockComponent );
			var provider : IComponentProvider = state.providers[MockComponent];
			assertThat( provider, instanceOf( ComponentTypeProvider ) );
			assertThat( provider.getComponent(), instanceOf( MockComponent ) );
		}
		
		[Test]
		public function addWithTypeQualifierCreatesTypeProvider() : void
		{
			state.add( MockComponent ).withType( MockComponent2 );
			var provider : IComponentProvider = state.providers[MockComponent];
			assertThat( provider, instanceOf( ComponentTypeProvider ) );
			assertThat( provider.getComponent(), instanceOf( MockComponent2 ) );
		}
		
		[Test]
		public function addWithInstanceQualifierCreatesInstanceProvider() : void
		{
			var component : MockComponent = new MockComponent();
			state.add( MockComponent ).withInstance( component );
			var provider : IComponentProvider = state.providers[MockComponent];
			assertThat( provider, instanceOf( ComponentInstanceProvider ) );
			assertThat( provider.getComponent(), equalTo( component ) );
		}

        [Test]
        public function addWithSingletonQualifierCreatesSingletonProvider() : void
        {
            state.add( MockComponent ).withSingleton( MockComponent );
            var provider : IComponentProvider = state.providers[MockComponent];
            assertThat( provider, instanceOf( ComponentSingletonProvider ) );
            assertThat( provider.getComponent(), instanceOf( MockComponent ) );
        }

        [Test]
        public function addWithMethodQualifierCreatesDynamicProvider() : void
        {
            const dynamicProvider:Function = function():*
            {
               return new MockComponent();
            };
            state.add( MockComponent ).withMethod( dynamicProvider );
            var provider : IComponentProvider = state.providers[MockComponent];
            assertThat( provider, instanceOf( DynamicComponentProvider ) );
            assertThat( provider.getComponent(), instanceOf( MockComponent ) );
        }
	}
}

class MockComponent
{
	public var value : int;
}

class MockComponent2 extends MockComponent
{
	
}