package net.richardlord.ash.core
{
	import net.richardlord.ash.signals.Signal0;

	import flash.utils.Dictionary;

	/**
	 * The game class is the central point for creating and managing your game state. Add
	 * entities and systems to the game, and fetch families of nodes from the game.
	 */
	public class Game
	{
		private var entities : EntityList;
		private var systems : SystemList;
		private var families : Dictionary;
		
		/**
		 * Indicates if the game is currently in its update loop.
		 */
		public var updating : Boolean;
		
		/**
		 * Dispatched when the update loop ends. If you want to add and remove systems from the
		 * game it is usually best not to do so during the update loop. To avoid this you can
		 * listen for this signal and make the change when the signal is dispatched.
		 */
		public var updateComplete : Signal0;
		
		public function Game()
		{
			entities = new EntityList();
			systems = new SystemList();
			families = new Dictionary();
			updateComplete = new Signal0();
		}
		
		/**
		 * Add an entity to the game.
		 * 
		 * @param entity The entity to add.
		 */
		public function addEntity( entity : Entity ) : void
		{
			entities.add( entity );
			entity.componentAdded.add( componentAdded );
			for each( var family : Family in families )
			{
				family.addIfMatch( entity );
			}
		}
		
		/**
		 * Remove an entity from the game.
		 * 
		 * @param entity The entity to remove.
		 */
		public function removeEntity( entity : Entity ) : void
		{
			for each( var family : Family in families )
			{
				family.remove( entity );
			}
			entity.componentAdded.remove( componentAdded );
			entities.remove( entity );
		}
		
		/**
		 * @private
		 */
		private function componentAdded( entity : Entity, componentClass : Class ) : void
		{
			for each( var family : Family in families )
			{
				family.addIfMatch( entity );
			}
		}
		
		/**
		 * Get a collection of nodes from the game, based on the type of the node required.
		 * 
		 * <p>The game will create the appropriate NodeList if it doesn't already exist and 
		 * will keep its contents up to date as entities are added to and removed from the
		 * game.</p>
		 * 
		 * <p>If a NodeList is no longer required, release it with the releaseNodeList method.</p>
		 * 
		 * @param nodeClass The type of node required.
		 * @return A linked list of all nodes of this type from all entities in the game.
		 */
		public function getNodeList( nodeClass : Class ) : NodeList
		{
			if( families[nodeClass] )
			{
				return Family( families[nodeClass] ).nodes;
			}
			var family : Family = new Family( nodeClass, this );
			families[nodeClass] = family;
			for( var entity : Entity = entities.head; entity; entity = entity.next )
			{
				family.addIfMatch( entity );
			}
			return family.nodes;
		}
		
		/**
		 * If a NodeList is no longer required, this method will stop the game updating
		 * the list and will release all references to the list within the framework
		 * classes, enabling it to be garbage collected.
		 * 
		 * <p>It is not essential to release a list, but releasing it will free
		 * up memory and processor resources.</p>
		 * 
		 * @param nodeClass The type of the node class if the list to be released.
		 */
		public function releaseNodeList( nodeClass : Class ) : void
		{
			if( families[nodeClass] )
			{
				families[nodeClass].cleanUp();
			}
			delete families[nodeClass];
		}
		
		/**
		 * Add a system to the game, and set its priority for the order in which the
		 * systems are updated by the game loop.
		 * 
		 * <p>The priority dictates the order in which the systems are updated by the game 
		 * loop. Lower numbers for priority are updated first. i.e. a priority of 1 is 
		 * updated before a priority of 2.</p>
		 * 
		 * @param system The system to add to the game.
		 * @param priority The priority for updating the systems during the game loop. A 
		 * lower number means the system is updated sooner.
		 */
		public function addSystem( system : System, priority : int ) : void
		{
			system.priority = priority;
			system.addToGame( this );
			systems.add( system );
		}
		
		/**
		 * Remove a system from the game.
		 * 
		 * @param system The system to remove from the game.
		 */
		public function removeSystem( system : System ) : void
		{
			systems.remove( system );
			system.removeFromGame( this );
		}

		/**
		 * Update the game. This causes the game loop to run, calling update on all the
		 * systems in the game.
		 * 
		 * <p>The package net.richardlord.ash.tick contains classes that can be used to provide
		 * a steady or variable tick that calls this update method.</p>
		 * 
		 * @time The duration, in seconds, of this update step.
		 */
		public function update( time : Number ) : void
		{
			updating = true;
			for( var system : System = systems.head; system; system = system.next )
			{
				system.update( time );
			}
			updating = false;
			updateComplete.dispatch();
		}
	}
}
