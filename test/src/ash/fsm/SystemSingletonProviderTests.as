package ash.fsm
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;

	public class SystemSingletonProviderTests
	{
		[Test]
		public function providerReturnsAnInstanceOfSystem() : void
		{
			var provider : SystemSingletonProvider = new SystemSingletonProvider( MockSystem );
			assertThat( provider.getSystem(), instanceOf( MockSystem ) );
		}

		[Test]
		public function providerReturnsSameInstanceEachTime() : void
		{
			var provider : SystemSingletonProvider = new SystemSingletonProvider( MockSystem );
			assertThat( provider.getSystem(), equalTo( provider.getSystem() ) );
		}

		[Test]
		public function providersWithSameSystemHaveDifferentIdentifier() : void
		{
			var provider1 : SystemSingletonProvider = new SystemSingletonProvider( MockSystem );
			var provider2 : SystemSingletonProvider = new SystemSingletonProvider( MockSystem );
			assertThat( provider1.identifier, not( provider2.identifier ) );
		}

		[Test]
		public function providersWithDifferentSystemsHaveDifferentIdentifier() : void
		{
			var provider1 : SystemSingletonProvider = new SystemSingletonProvider( MockSystem );
			var provider2 : SystemSingletonProvider = new SystemSingletonProvider( MockSystem2 );
			assertThat( provider1.identifier, not( provider2.identifier ) );
		}
	}
}

import ash.core.System;

class MockSystem extends System
{
	public var value : int;
}

class MockSystem2  extends System
{
	public var value : String;
}
