package ash.fsm
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.sameInstance;

	public class ComponentInstanceProviderTests
	{
		[Test]
		public function providerReturnsTheInstance() : void
		{
			var instance : MockComponent = new MockComponent();
			var provider : ComponentInstanceProvider = new ComponentInstanceProvider( instance );
			assertThat( provider.getComponent(), sameInstance( instance ) );
		}

		[Test]
		public function providersWithSameInstanceHaveSameIdentifier() : void
		{
			var instance : MockComponent = new MockComponent();
			var provider1 : ComponentInstanceProvider = new ComponentInstanceProvider( instance );
			var provider2 : ComponentInstanceProvider = new ComponentInstanceProvider( instance );
			assertThat( provider1.identifier, equalTo( provider2.identifier ) );
		}

		[Test]
		public function providersWithDifferentInstanceHaveDifferentIdentifier() : void
		{
			var provider1 : ComponentInstanceProvider = new ComponentInstanceProvider( new MockComponent() );
			var provider2 : ComponentInstanceProvider = new ComponentInstanceProvider( new MockComponent() );
			assertThat( provider1.identifier, not( provider2.identifier ) );
		}
	}
}

class MockComponent
{
	public var value : int;
}
