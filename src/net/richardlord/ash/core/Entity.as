package net.richardlord.ash.core
{
	import flash.utils.Dictionary;
	import net.richardlord.ash.signals.Signal2;


	public class Entity
	{
		public var name : String;
		
		internal var componentAdded : Signal2;
		internal var componentRemoved : Signal2;
		internal var previous : Entity;
		internal var next : Entity;
		
		internal var components : Dictionary;

		public function Entity()
		{
			componentAdded = new Signal2( Entity, Class );
			componentRemoved = new Signal2( Entity, Class );
			components = new Dictionary();
		}

		public function add( component : Object, componentClass : Class = null ) : void
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
		}

		public function remove( componentClass : Class ) : void
		{
			if ( components[ componentClass ] )
			{
				delete components[ componentClass ];
				componentRemoved.dispatch( this, componentClass );
			}
		}

		public function get( componentClass : Class ) : *
		{
			return components[ componentClass ];
		}

		public function has( componentClass : Class ) : Boolean
		{
			return components[ componentClass ] != null;
		}
	}
}
