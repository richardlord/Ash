package ash.fsm
{
import ash.core.System;

/**
 * Used by the SystemState class to create the mappings of Systems to providers via a fluent interface.
 */
internal class StateSystemMapping
{
    /**
     * Used internally, the constructor creates a component mapping. The constructor
     * creates a SystemSingletonProvider as the default mapping, which will be replaced
     * by more specific mappings if other methods are called.
     *
     * @param creatingState The SystemState that the mapping will belong to
     * @param type The System type for the mapping
     */
    public function StateSystemMapping( creatingState:SystemState, type:Class )
    {
        this.creatingState = creatingState;
        componentType = type;
        withSingleton( type );
    }

    private var componentType:Class;
    private var creatingState:SystemState;
    private var provider:ISystemProvider;

    /**
     * Creates a mapping for the System type to a specific System instance. A
     * SystemInstanceProvider is used for the mapping.
     *
     * @param system The System instance to use for the mapping
     * @return This ComponentMapping, so more modifications can be applied
     */
    public function withInstance( system:System ):StateSystemMapping
    {
        setProvider( new SystemInstanceProvider( system ) );
        return this;
    }

    /**
     * Creates a mapping for the System type to a single instance of the provided type.
     * The instance is not created until it is first requested. The type should be the same
     * as or extend the type for this mapping. A SystemSingletonProvider is used for
     * the mapping.
     *
     * @param type The type of the single instance to be created. If omitted, the type of the
     * mapping is used.
     * @return This ComponentMapping, so more modifications can be applied
     */
    public function withSingleton( type:Class = null ):StateSystemMapping
    {
        if( !type )
        {
            type = componentType;
        }
        setProvider( new SystemSingletonProvider( type ) );
        return this;

    }

    /**
     * Creates a mapping for the System type to a method call.
     * The method should return a System instance.
     *
     * @param method The method to provide the System instance.
     * @return This ComponentMapping, so more modifications can be applied.
     */
    public function withMethod( method:Function ):StateSystemMapping
    {
        setProvider( new SystemMethodProvider( method ) );
        return this;
    }

    /**
     * Applies the priority to the provider that the System will be.
     *
     * @param priority The component provider to use.
     * @return This ComponentMapping, so more modifications can be applied.
     */
    public function withPriority( priority:int ):StateSystemMapping
    {
        getProvider(componentType ).priority = priority;
        return this;
    }

    /**
     * Creates a mapping for the System type to any ComponentProvider.
     *
     * @param provider The component provider to use.
     * @return This ComponentMapping, so more modifications can be applied.
     */
    public function withProvider( provider:ISystemProvider ):StateSystemMapping
    {
        this.provider = provider;
        creatingState.providers[ componentType ] = provider;
        return this;
    }

    /**
     * Maps through to the add method of the SystemState that this mapping belongs to
     * so that a fluent interface can be used when configuring entity states.
     *
     * @param type The type of System to add a mapping to the state for
     * @return The new ComponentMapping for that type
     */
    public function add( type:Class ):StateSystemMapping
    {
        return creatingState.add( type );
    }

    private function setProvider( provider:ISystemProvider ):void
    {
        if( this.provider != null){
            provider.priority = this.provider.priority;
        }
        this.provider = provider;
        creatingState.providers[ componentType ] = provider;
    }

    private function getProvider( type:Class ):ISystemProvider
    {
       return creatingState.providers[ componentType ];
    }
}
}
