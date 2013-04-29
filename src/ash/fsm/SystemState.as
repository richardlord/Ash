package ash.fsm
{
import flash.utils.Dictionary;
/**
 * Represents a state for a SystemStateMachine. The state contains any number of SystemProviders which
 * are used to add Systems to the Engine when this state is entered.
 */
public class SystemState
{

    internal var providers:Dictionary = new Dictionary();

    /**
     * Add a new StateSystemMapping to this state. The mapping is a utility class that is used to
     * map a component type to the provider that provides the component.
     *
     * @param type The type of System to be mapped
     * @return The system mapping to use when setting the provider for the system
     */
    public function add( type:Class ):StateSystemMapping
    {
        return new StateSystemMapping( this, type );
    }


    /**
     * Get the SystemProvider for a particular component type.
     *
     * @param type The type of System to get the provider for
     * @return The SystemProvider
     */
    public function get( type:Class ):ISystemProvider
    {
        return providers[ type ];
    }

    /**
     * To determine whether this state has a provider for a specific System type.
     *
     * @param type The type of System to look for a provider for
     * @return true if there is a provider for the given type, false otherwise
     */
    public function has( type:Class ):Boolean
    {
        return providers[ type ] != null;
    }
}
}
