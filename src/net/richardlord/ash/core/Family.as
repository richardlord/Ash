package net.richardlord.ash.core
{
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	import flash.utils.getDefinitionByName;

	internal class Family
	{
		internal var previous : Family;
		internal var next : Family;
		internal var nodes : NodeList;
		internal var entities : Dictionary;
		private var nodeClass : Class;
		private var components : Dictionary;

		public function Family( nodeClass : Class )
		{
			this.nodeClass = nodeClass;
			init();
		}

		private function init() : void
		{
			nodes = new NodeList();
			entities = new Dictionary();

			components = new Dictionary();
			var node : * = new nodeClass();

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

		internal function addIfMatch( entity : Entity ) : void
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
				var node : Node = new nodeClass();
				node.entity = entity;
				for ( componentClass in components )
				{
					node[components[componentClass]] = entity.get( componentClass );
				}
				nodes.add( node );
				entities[entity] = node;
				entity.componentRemoved.add( componentRemoved );
			}
		}
		
		internal function remove( entity : Entity ) : void
		{
			if( entities[entity] )
			{
				entity.componentRemoved.remove( componentRemoved );
				nodes.remove( entities[entity] );
				delete entities[entity];
			}
		}
		
		private function componentRemoved( entity : Entity, componentClass : Class ) : void
		{
			if( components[componentClass] )
			{
				remove( entity );
			}
		}
	}
}
