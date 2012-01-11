package net.richardlord.ash.core
{
	import flash.utils.Dictionary;

	public class Game
	{
		private var entities : EntityList;
		private var systems : SystemList;
		private var families : Dictionary;
		
		public function Game()
		{
			entities = new EntityList();
			systems = new SystemList();
			families = new Dictionary();
		}
		
		public function addEntity( entity : Entity ) : void
		{
			entities.add( entity );
			entity.componentAdded.add( componentAdded );
			for each( var family : Family in families )
			{
				family.addIfMatch( entity );
			}
		}
		
		public function removeEntity( entity : Entity ) : void
		{
			for each( var family : Family in families )
			{
				family.remove( entity );
			}
			entity.componentAdded.remove( componentAdded );
			entities.remove( entity );
		}
		
		private function componentAdded( entity : Entity, componentClass : Class ) : void
		{
			for each( var family : Family in families )
			{
				family.addIfMatch( entity );
			}
		}
		
		public function getFamily( nodeClass : Class ) : NodeList
		{
			if( families[nodeClass] )
			{
				return Family( families[nodeClass] ).nodes;
			}
			var family : Family = new Family( nodeClass );
			families[nodeClass] = family;
			for( var entity : Entity = entities.head; entity; entity = entity.next )
			{
				family.addIfMatch( entity );
			}
			return family.nodes;
		}
		
		public function releaseFamily( nodeClass : Class ) : void
		{
			if( families[nodeClass] )
			{
				families[nodeClass].cleanUp();
			}
			delete families[nodeClass];
		}
		
		public function addSystemWithPriority( system : System, priority : int ) : void
		{
			system.priority = priority;
			addSystem( system );
		}

		public function addSystem( system : System ) : void
		{
			system.addToGame( this );
			systems.add( system );
		}
		
		public function removeSystem( system : System ) : void
		{
			systems.remove( system );
			system.removeFromGame( this );
		}

		public function update( time : Number ) : void
		{
			for( var system : System = systems.head; system; system = system.next )
			{
				system.update( time );
			}
		}
	}
}
