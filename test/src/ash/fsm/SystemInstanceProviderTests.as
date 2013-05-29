package ash.fsm
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.not;
	import org.hamcrest.object.equalTo;
import org.hamcrest.object.notNullValue;
import org.hamcrest.object.sameInstance;

	public class SystemInstanceProviderTests
	{
		[Test]
		public function providerReturnsTheInstance() : void
		{
			var instance : MockSystem = new MockSystem();
			var provider : SystemInstanceProvider = new SystemInstanceProvider( instance );
            assertThat( provider.getSystem(), sameInstance( instance ) );
		}

		[Test]
		public function providersWithSameInstanceHaveSameIdentifier() : void
		{
			var instance : MockSystem = new MockSystem();
			var provider1 : SystemInstanceProvider = new SystemInstanceProvider( instance );
			var provider2 : SystemInstanceProvider = new SystemInstanceProvider( instance );
			assertThat( provider1.identifier, equalTo( provider2.identifier ) );
		}

		[Test]
		public function providersWithDifferentInstanceHaveDifferentIdentifier() : void
		{
			var provider1 : SystemInstanceProvider = new SystemInstanceProvider( new MockSystem() );
			var provider2 : SystemInstanceProvider = new SystemInstanceProvider( new MockSystem() );
			assertThat( provider1.identifier, not( provider2.identifier ) );
		}
	}
}

import ash.core.System;

class MockSystem  extends  System
{
	public var value : int;
}
