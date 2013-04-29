package ash.fsm
{
import ash.core.Engine;

import flash.utils.Dictionary;
/**
 * This is a state machine for the Engine. The state machine manages a set of states,
 * each of which has a set of System providers. When the state machine changes the state, it removes
 * Systems associated with the previous state and adds Systems associated with the new state.
 */
public class SystemStateMachine
{
    /**
     * Constructor. Creates an SystemStateMachine.
     */
    public function SystemStateMachine( engine:Engine ):void
    {
        this.engine = engine;
        states = new Dictionary();
    }

    public var engine:Engine;
    private var states:Dictionary;
    private var currentState:SystemState;

    /**
     * Add a state to this state machine.
     *
     * @param name The name of this state - used to identify it later in the changeState method call.
     * @param state The state.
     * @return This state machine, so methods can be chained.
     */
    public function addState( name:String, state:SystemState ):SystemStateMachine
    {
        states[ name ] = state;
        return this;
    }

    /**
     * Create a new state in this state machine.
     *
     * @param name The name of the new state - used to identify it later in the changeState method call.
     * @return The new EntityState object that is the state. This will need to be configured with
     * the appropriate component providers.
     */
    public function createState( name:String ):SystemState
    {
        var state : SystemState = new SystemState();
        states[ name ] = state;
        return state;
    }

    /**
     * Change to a new state. The Systems from the old state will be removed and the Systems
     * for the new state will be added.
     *
     * @param name The name of the state to change to.
     */
    public function changeState( name:String ):void
    {
        var newState : SystemState = states[ name ];
        if ( !newState )
        {
            throw( new Error( "System state " + name + " doesn't exist" ) );
        }
        if( newState == currentState )
        {
            newState = null;
            return;
        }
        var toAdd : Dictionary;
        var provider:ISystemProvider;
        var type : Class;
        var t : *;
        if ( currentState )
        {
            toAdd = new Dictionary();
            for( t in newState.providers )
            {
                type = Class( t );
                toAdd[ type ] = newState.providers[ type ];
            }
            for( t in currentState.providers )
            {
                type = Class( t );
                var other : ISystemProvider = toAdd[ type ];

                if ( other && other.identifier == currentState.providers[ type ].identifier )
                {
                    delete toAdd[ type ];
                }
                else
                {
                    provider = currentState.providers[ type ];
                    engine.removeSystem( provider.getSystem() );
                }
            }
        }
        else
        {
            toAdd = newState.providers;
        }
        for( t in toAdd )
        {
            type = Class( t );
            provider = toAdd[ type ];
            engine.addSystem( provider.getSystem(), provider.priority );
        }
        currentState = newState;
    }
}
}
