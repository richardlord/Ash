package net.richardlord.ash.fsm
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;

	public class ComponentSingletonProviderTests
	{
		[Test]
		public function providerReturnsAnInstanceOfType() : void
		{
			var provider : ComponentSingletonProvider = new ComponentSingletonProvider( MockComponent );
			assertThat( provider.component, instanceOf( MockComponent ) );
		}

		[Test]
		public function providerReturnsSameInstanceEachTime() : void
		{
			var provider : ComponentSingletonProvider = new ComponentSingletonProvider( MockComponent );
			assertThat( provider.component, equalTo( provider.component ) );
		}

		[Test]
		public function providersWithSameTypeHaveDifferentIdentifier() : void
		{
			var provider1 : ComponentSingletonProvider = new ComponentSingletonProvider( MockComponent );
			var provider2 : ComponentSingletonProvider = new ComponentSingletonProvider( MockComponent );
			assertThat( provider1.identifier, not( provider2.identifier ) );
		}

		[Test]
		public function providersWithDifferentTypeHaveDifferentIdentifier() : void
		{
			var provider1 : ComponentSingletonProvider = new ComponentSingletonProvider( MockComponent );
			var provider2 : ComponentSingletonProvider = new ComponentSingletonProvider( MockComponent2 );
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
