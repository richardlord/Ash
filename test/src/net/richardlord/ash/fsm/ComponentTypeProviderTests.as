package net.richardlord.ash.fsm
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;

	public class ComponentTypeProviderTests
	{
		[Test]
		public function providerReturnsAnInstanceOfType() : void
		{
			var provider : ComponentTypeProvider = new ComponentTypeProvider( MockComponent );
			assertThat( provider.component, instanceOf( MockComponent ) );
		}

		[Test]
		public function providerReturnsNewInstanceEachTime() : void
		{
			var provider : ComponentTypeProvider = new ComponentTypeProvider( MockComponent );
			assertThat( provider.component, not( provider.component ) );
		}

		[Test]
		public function providersWithSameTypeHaveSameIdentifier() : void
		{
			var provider1 : ComponentTypeProvider = new ComponentTypeProvider( MockComponent );
			var provider2 : ComponentTypeProvider = new ComponentTypeProvider( MockComponent );
			assertThat( provider1.identifier, equalTo( provider2.identifier ) );
		}

		[Test]
		public function providersWithDifferentTypeHaveDifferentIdentifier() : void
		{
			var provider1 : ComponentTypeProvider = new ComponentTypeProvider( MockComponent );
			var provider2 : ComponentTypeProvider = new ComponentTypeProvider( MockComponent2 );
			assertThat( provider1.identifier, not( provider2.identifier ) );
		}
	}
}

class MockComponent
{
	public var value : int;
}

class MockComponent2
{
	public var value : String;
}
