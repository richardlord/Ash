package net.richardlord.ash.core
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import net.richardlord.signals.Signal2;


	/**
	 * A game entity is a collection object for components. Sometimes, the entities in a game
	 * will mirror the actual characters and objects in the game, but this is not necessary.
	 * 
	 * <p>Components are simple value objects that contain data relevant to the entity. Entities
	 * with similar functionality will have instances of the same components. So we might have 
	 * a position component</p>
	 * 
	 * <p><code>public class PositionComponent
	 * {
	 *   public var x : Number;
	 *   public var y : Number;
	 * }</code></p>
	 * 
	 * <p>All entities that have a position in the game world, will have an instance of the
	 * position component. Systems operate on entities based on the components they have.</p>
	 */
	public class Entity
	{
		/**
		 * Optional, give the entity a name. This can help with debugging and with serialising the entity.
		 */
		public var name : String;
		/**
		 * This signal is dispatched when a component is added to the entity.
		 */
		public var componentAdded : Signal2;
		/**
		 * This signal is dispatched when a component is removed from the entity.
		 */
		public var componentRemoved : Signal2;
		
		internal var previous : Entity;
		internal var next : Entity;
		internal var components : Dictionary;

		public function Entity()
		{
			componentAdded = new Signal2( Entity, Class );
			componentRemoved = new Signal2( Entity, Class );
			components = new Dictionary();
		}

		/**
		 * Add a component to the entity.
		 * 
		 * @param component The component object to add.
		 * @param componentClass The class of the component. This is only necessary if the component
		 * extends another component class and you want the framework to treat the component as of 
		 * the base class type. If not set, the class type is determined directly from the component.
		 * 
		 * @return A reference to the entity. This enables the chaining of calls to add, to make
		 * creating and configuring entities cleaner. e.g.
		 * 
		 * <code>var entity : Entity = new Entity()
		 *     .add( new Position( 100, 200 )
		 *     .add( new Display( new PlayerClip() );</code>
		 */
		public function add( component : Object, componentClass : Class = null ) : Entity
		{
			if ( !componentClass )
			{
				componentClass = Class( component.constructor );
			}
			if ( components[ componentClass ] )
			{
				remove( componentClass );
			}
			components[ componentClass ] = component;
			componentAdded.dispatch( this, componentClass );
			return this;
		}

		/**
		 * Remove a component from the entity.
		 * 
		 * @param componentClass The class of the component to be removed.
		 * @return the component, or null if the component doesn't exist in the entity
		 */
		public function remove( componentClass : Class ) : *
		{
			var component : * = components[ componentClass ];
			if ( component )
			{
				delete components[ componentClass ];
				componentRemoved.dispatch( this, componentClass );
				return component;
			}
			return null;
		}

		/**
		 * Get a component from the entity.
		 * 
		 * @param componentClass The class of the component requested.
		 * @return The component, or null if none was found.
		 */
		public function get( componentClass : Class ) : *
		{
			return components[ componentClass ];
		}
		
		/**
		 * Get all components from the entity.
		 * 
		 * @return An array containing all the components that are on the entity.
		 */
		public function getAll() : Array
		{
			var componentArray : Array = new Array();
			for each( var component : * in components )
			{
				componentArray.push( component );
			}
			return componentArray;
		}

		/**
		 * Does the entity have a component of a particular type.
		 * 
		 * @param componentClass The class of the component sought.
		 * @return true if the entity has a component of the type, false if not.
		 */
		public function has( componentClass : Class ) : Boolean
		{
			return components[ componentClass ] != null;
		}
		
		/**
		 * Make a copy of the entity
		 * 
		 * @return A new entity with new components that are copies of the components on the
		 * original entity.
		 */
		public function clone() : Entity
		{
			var copy : Entity = new Entity();
			for each( var component : Object in components )
			{
				var names : XMLList = describeType( component ).variable.@name;
				var componentClass : Class = component.constructor as Class;
				var newComponent : * = new componentClass();
				for each( var key : String in names )
				{
					newComponent[key] = component[key];
				}
				copy.add( newComponent );
			}
			return copy;
		}
	}
}
