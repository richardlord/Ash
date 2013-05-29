package ash.fsm
{
import org.hamcrest.assertThat;
import org.hamcrest.core.not;
import org.hamcrest.object.equalTo;
import org.hamcrest.object.sameInstance;

public class DynamicComponentProviderTests
{
    [Test]
    public function providerReturnsTheInstance():void
    {
        var instance:MockComponent = new MockComponent();
        var providerMethod:Function = function ():*
        {
            return instance;
        }
        var provider:DynamicComponentProvider = new DynamicComponentProvider( providerMethod );
        assertThat( provider.getComponent(), sameInstance( instance ) );
    }

    [Test]
    public function providersWithSameMethodHaveSameIdentifier():void
    {
        var instance:MockComponent = new MockComponent();
        var providerMethod:Function = function ():*
        {
            return instance;
        }

        var provider1:DynamicComponentProvider = new DynamicComponentProvider( providerMethod );
        var provider2:DynamicComponentProvider = new DynamicComponentProvider( providerMethod );
        assertThat( provider1.identifier, equalTo( provider2.identifier ) );
    }

    [Test]
    public function providersWithDifferentMethodsHaveDifferentIdentifier():void
    {
        var instance:MockComponent = new MockComponent();
        var providerMethod1:Function = function ():*
        {
            return instance;
        }

        var providerMethod2:Function = function ():*
        {
            return instance;
        }

        var provider1:DynamicComponentProvider = new DynamicComponentProvider( providerMethod1 );
        var provider2:DynamicComponentProvider = new DynamicComponentProvider( providerMethod2 );
        assertThat( provider1.identifier, not( provider2.identifier ) );
    }
}
}

class MockComponent
{
    public var value:int;
}
