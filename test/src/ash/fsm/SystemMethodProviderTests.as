package ash.fsm
{
import ash.core.System;

import org.hamcrest.assertThat;
import org.hamcrest.core.not;
import org.hamcrest.object.sameInstance;
import org.hamcrest.object.strictlyEqualTo;

public class SystemMethodProviderTests
{
    [Test]
    public function providerReturnsTheInstance():void
    {
        var instance:MockSystem = new MockSystem();
        var providerMethod:Function = function ():System
        {
            return instance;
        }

        var provider:DynamicSystemProvider = new DynamicSystemProvider( providerMethod );
        assertThat( provider.getSystem(), sameInstance( instance ) );
    }

    [Test]
    public function providersWithSameMethodHaveSameIdentifier():void
    {
        var instance:MockSystem = new MockSystem();
        var providerMethod:Function = function ():System
        {
            return instance;
        }
        var provider1:DynamicSystemProvider = new DynamicSystemProvider( providerMethod );
        var provider2:DynamicSystemProvider = new DynamicSystemProvider( providerMethod );
        assertThat( provider1.identifier, strictlyEqualTo( provider2.identifier ) );
    }

    [Test]
    public function providersWithDifferentMethodHaveDifferentIdentifier():void
    {
        var instance:MockSystem = new MockSystem();
        var providerMethod1:Function = function ():System
        {
            return instance;
        }

        var providerMethod2:Function = function ():System
        {
            return instance;
        }

        var provider1:DynamicSystemProvider = new DynamicSystemProvider( providerMethod1 );
        var provider2:DynamicSystemProvider = new DynamicSystemProvider( providerMethod2 );
        assertThat( provider1.identifier, not( provider2.identifier ) );
    }
}
}

import ash.core.System;

class MockSystem extends System
{

}
