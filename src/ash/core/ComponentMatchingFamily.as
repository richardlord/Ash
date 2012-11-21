package ash.core
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	/**
	 * A default class for managing a NodeList. This class creates the NodeList and adds and removes
	 * nodes to/from the list as the entities and the components in the engine change.
	 * 
	 * It uses the basic entity matching pattern of an entity system - entities are added to the list if
	 * they contain components matching all the public properties of the node class.
	 */
	public class ComponentMatchingFamily implements IFamily
	{
		private var nodes : NodeList;
		private var entities : Dictionary;
		private var nodeClass : Class;
		private var components : Dictionary;
		private var nodePool : NodePool;
		private var engine : Engine;

		public function ComponentMatchingFamily( nodeClass : Class, engine : Engine )
		{
			this.nodeClass = nodeClass;
			this.engine = engine;
			init();
		}

		private function init() : void
		{
			nodePool = new NodePool( nodeClass );
			nodes = new NodeList();
			entities = new Dictionary();

			components = new Dictionary();
			nodePool.dispose( nodePool.get() ); // create a dummy instance to ensure describeType works.

			var variables : XMLList = describeType( nodeClass ).factory.variable;
			for each ( var atom:XML in variables )
			{
				if ( atom.@name != "entity" && atom.@name != "previous" && atom.@name != "next" )
				{
					var componentClass : Class = getDefinitionByName( atom.@type ) as Class;
					components[componentClass] = atom.@name.toString();
				}
			}
		}
		
		public function get nodeList() : NodeList
		{
			return nodes;
		}

		public function newEntity( entity : Entity ) : void
		{
			addIfMatch( entity );
		}
		
		public function componentAddedToEntity( entity : Entity, componentClass : Class ) : void
		{
			addIfMatch( entity );
		}
		
		public function componentRemovedFromEntity( entity : Entity, componentClass : Class ) : void
		{
			if( components[componentClass] )
			{
				removeIfMatch( entity );
			}
		}
		
		public function removeEntity( entity : Entity ) : void
		{
			removeIfMatch( entity );
		}
		
		private function addIfMatch( entity : Entity ) : void
		{
			if( !entities[entity] )
			{
				var componentClass : *;
				for ( componentClass in components )
				{
					if ( !entity.has( componentClass ) )
					{
						return;
					}
				}
				var node : Node = nodePool.get();
				node.entity = entity;
				for ( componentClass in components )
				{
					node[components[componentClass]] = entity.get( componentClass );
				}
				entities[entity] = node;
				nodes.add( node );
			}
		}
		
		private function removeIfMatch( entity : Entity ) : void
		{
			if( entities[entity] )
			{
				var node : Node = entities[entity];
				delete entities[entity];
				nodes.remove( node );
				if( engine.updating )
				{
					nodePool.cache( node );
					engine.updateComplete.add( releaseNodePoolCache );
				}
				else
				{
					nodePool.dispose( node );
				}
			}
		}
		
		private function releaseNodePoolCache() : void
		{
			engine.updateComplete.remove( releaseNodePoolCache );
			nodePool.releaseCache();
		}
		
		public function cleanUp() : void
		{
			for( var node : Node = nodes.head; node; node = node.next )
			{
				delete entities[node.entity];
			}
			nodes.removeAll();
		}
	}
}
