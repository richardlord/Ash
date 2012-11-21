package ash.core
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.emptyArray;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.object.nullValue;
	import org.hamcrest.object.sameInstance;

	public class ComponentMatchingFamilyTests
	{
		private var engine : Engine;
		private var family : ComponentMatchingFamily;
		
		[Before]
		public function createFamily() : void
		{
			engine = new Engine();
			family = new ComponentMatchingFamily( MockNode, engine );
		}

		[After]
		public function clearFamily() : void
		{
			family = null;
			engine = null;
		}
		
		[Test]
		public function testNodeListIsInitiallyEmpty() : void
		{
			var nodes : NodeList = family.nodeList;
			assertThat( nodes.head, nullValue() );
		}
		
		[Test]
		public function testMatchingEntityIsAddedWhenAccessNodeListFirst() : void
		{
			var nodes : NodeList = family.nodeList;
			var entity : Entity = new Entity();
			entity.add( new Point() );
			family.newEntity( entity );
			assertThat( nodes.head.entity, sameInstance( entity ) );
		}
		
		[Test]
		public function testMatchingEntityIsAddedWhenAccessNodeListSecond() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			family.newEntity( entity );
			var nodes : NodeList = family.nodeList;
			assertThat( nodes.head.entity, sameInstance( entity ) );
		}
		
		[Test]
		public function testNodeContainsEntityProperties() : void
		{
			var entity : Entity = new Entity();
			var point : Point = new Point();
			entity.add( point );
			family.newEntity( entity );
			var nodes : NodeList = family.nodeList;
			assertThat( nodes.head.point, sameInstance( point ) );
		}
		
		[Test]
		public function testMatchingEntityIsAddedWhenComponentAdded() : void
		{
			var nodes : NodeList = family.nodeList;
			var entity : Entity = new Entity();
			entity.add( new Point() );
			family.componentAddedToEntity( entity, Point );
			assertThat( nodes.head.entity, sameInstance( entity ) );
		}
		
		[Test]
		public function testNonMatchingEntityIsNotAdded() : void
		{
			var entity : Entity = new Entity();
			family.newEntity( entity );
			var nodes : NodeList = family.nodeList;
			assertThat( nodes.head, nullValue() );
		}
		
		[Test]
		public function testNonMatchingEntityIsNotAddedWhenComponentAdded() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Matrix() );
			family.componentAddedToEntity( entity, Matrix );
			var nodes : NodeList = family.nodeList;
			assertThat( nodes.head, nullValue() );
		}
		
		[Test]
		public function testEntityIsRemovedWhenAccessNodeListFirst() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			family.newEntity( entity );
			var nodes : NodeList = family.nodeList;
			family.removeEntity( entity );
			assertThat( nodes.head, nullValue() );
		}
		
		[Test]
		public function testEntityIsRemovedWhenAccessNodeListSecond() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			family.newEntity( entity );
			family.removeEntity( entity );
			var nodes : NodeList = family.nodeList;
			assertThat( nodes.head, nullValue() );
		}
		
		[Test]
		public function testEntityIsRemovedWhenComponentRemoved() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			family.newEntity( entity );
			entity.remove( Point );
			family.componentRemovedFromEntity( entity, Point );
			var nodes : NodeList = family.nodeList;
			assertThat( nodes.head, nullValue() );
		}

		[Test]
		public function nodeListContainsOnlyMatchingEntities() : void
		{
			var entities : Array = new Array();
			for( var i : int = 0; i < 5; ++i )
			{
				var entity : Entity = new Entity();
				entity.add( new Point() );
				entities.push( entity );
				family.newEntity( entity );
				family.newEntity( new Entity() );
			}
			
			var nodes : NodeList = family.nodeList;
			var node : MockNode;
			for( node = nodes.head; node; node = node.next )
			{
				assertThat( entities, hasItem( node.entity ) );
			}
		}

		[Test]
		public function nodeListContainsAllMatchingEntities() : void
		{
			var entities : Array = new Array();
			for( var i : int = 0; i < 5; ++i )
			{
				var entity : Entity = new Entity();
				entity.add( new Point() );
				entities.push( entity );
				family.newEntity( entity );
				family.newEntity( new Entity() );
			}
			
			var nodes : NodeList = family.nodeList;
			var node : MockNode;
			for( node = nodes.head; node; node = node.next )
			{
				var index : int = entities.indexOf( node.entity );
				entities.splice( index, 1 );
			}
			assertThat( entities, emptyArray() );
		}
		
		[Test]
		public function cleanUpEmptiesNodeList() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			family.newEntity( entity );
			var nodes : NodeList = family.nodeList;
			family.cleanUp();
			assertThat( nodes.head, nullValue() );
		}

		[Test]
		public function cleanUpSetsNextNodeToNull() : void
		{
			var entities : Array = new Array();
			for( var i : int = 0; i < 5; ++i )
			{
				var entity : Entity = new Entity();
				entity.add( new Point() );
				entities.push( entity );
				family.newEntity( entity );
			}
			
			var nodes : NodeList = family.nodeList;
			var node : MockNode = nodes.head.next;
			family.cleanUp();
			assertThat( node.next, nullValue() );
		}
	}
}
import ash.core.Node;
import flash.geom.Point;


class MockNode extends Node
{
	public var point : Point;
}