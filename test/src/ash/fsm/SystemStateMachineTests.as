package ash.fsm
{
import ash.core.Engine;

import asunit.framework.IAsync;

import org.hamcrest.assertThat;
import org.hamcrest.object.isFalse;
import org.hamcrest.object.nullValue;
import org.hamcrest.object.sameInstance;

public class SystemStateMachineTests
{
    [Inject]
    public var async:IAsync;

    private var fsm:SystemStateMachine;
    private var engine:Engine;

    [Before]
    public function createState():void
    {
        engine = new Engine();
        fsm = new SystemStateMachine( engine );
    }

    [After]
    public function clearState():void
    {
        engine = null;
        fsm = null;
    }

    [Test]
    public function enterStateAddsStatesSystems():void
    {
        var state:SystemState = new SystemState();
        var system:MockSystem = new MockSystem();
        state.add( MockSystem ).withInstance( system );
        fsm.addState( "test", state );
        fsm.changeState( "test" );
        assertThat( engine.getSystem( MockSystem ), sameInstance( system ) );
    }


    [Test]
    public function enterSecondStateAddsSecondStatesSystems():void
    {
        var state1:SystemState = new SystemState();
        var system1:MockSystem = new MockSystem();
        state1.add( MockSystem ).withInstance( system1 );
        fsm.addState( "test1", state1 );
        fsm.changeState( "test1" );

        var state2:SystemState = new SystemState();
        var system2:MockSystem2 = new MockSystem2();
        state2.add( MockSystem2 ).withInstance( system2 );
        fsm.addState( "test2", state2 );
        fsm.changeState( "test2" );

        assertThat( engine.getSystem( MockSystem2 ), sameInstance( system2 ) );

    }


    [Test]
    public function enterSecondStateRemovesFirstStatesComponents():void
    {
        var state1:SystemState = new SystemState();
        var system1:MockSystem = new MockSystem();
        state1.add( MockSystem ).withInstance( system1 );
        fsm.addState( "test1", state1 );
        fsm.changeState( "test1" );

        var state2:SystemState = new SystemState();
        var system2:MockSystem2 = new MockSystem2();
        state2.add( MockSystem2 ).withInstance( system2 );
        fsm.addState( "test2", state2 );
        fsm.changeState( "test2" );

        assertThat( engine.getSystem( MockSystem ), nullValue() );
    }


    [Test]
    public function enterSecondStateDoesNotRemoveOverlappingComponents():void
    {
        var state1:SystemState = new SystemState();
        var system1:MockSystem = new MockSystem();
        state1.add( MockSystem ).withInstance( system1 );
        fsm.addState( "test1", state1 );
        fsm.changeState( "test1" );

        var state2:SystemState = new SystemState();
        var system2:MockSystem2 = new MockSystem2();
        state2.add( MockSystem ).withInstance( system1 );
        state2.add( MockSystem2 ).withInstance( system2 );
        fsm.addState( "test2", state2 );
        fsm.changeState( "test2" );

        assertThat( system1.wasRemoved, isFalse() );
        assertThat( engine.getSystem( MockSystem ), sameInstance( system1 ) );
    }

    [Test]
    public function enterSecondStateRemovesDifferentComponentsOfSameType():void
    {
        var state1:SystemState = new SystemState();
        var component1:MockSystem = new MockSystem();
        state1.add( MockSystem ).withInstance( component1 );
        fsm.addState( "test1", state1 );
        fsm.changeState( "test1" );

        var state2:SystemState = new SystemState();
        var system3:MockSystem = new MockSystem();
        var system2:MockSystem2 = new MockSystem2();
        state2.add( MockSystem ).withInstance( system3 );
        state2.add( MockSystem2 ).withInstance( system2 );
        fsm.addState( "test2", state2 );
        fsm.changeState( "test2" );

        assertThat( engine.getSystem( MockSystem ), sameInstance( system3 ) );
    }

}
}

import ash.core.Engine;
import ash.core.System;

class MockSystem extends System
{
    public var wasRemoved:Boolean = false;

    override public function removeFromEngine( engine:Engine ):void
    {
        wasRemoved = true;
    }
}

class MockSystem2 extends System
{
    public var value:String;
}
