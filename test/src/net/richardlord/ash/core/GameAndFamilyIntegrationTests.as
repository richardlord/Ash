package net.richardlord.ash.core
{
	import asunit.framework.IAsync;

	import org.hamcrest.assertThat;
	import org.hamcrest.collection.emptyArray;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.object.nullValue;
	import org.hamcrest.object.sameInstance;

	import flash.geom.Matrix;
	import flash.geom.Point;
	
	/**
	 * Tests the family class through the game class. Left over from a previous 
	 * architecture but retained because all tests shoudl still pass.
	 */
	public class GameAndFamilyIntegrationTests
	{
		[Inject]
		public var async : IAsync;
		
		private var game : Game;
		
		[Before]
		public function createEntity() : void
		{
			game = new Game();
		}

		[After]
		public function clearEntity() : void
		{
			game = null;
		}

		[Test]
		public function testFamilyIsInitiallyEmpty() : void
		{
			var nodes : NodeList = game.getNodeList( MockNode );
			assertThat( nodes.head, nullValue() );
		}

		[Test]
		public function testNodeContainsEntityProperties() : void
		{
			var entity : Entity = new Entity();
			var point : Point = new Point();
			var matrix : Matrix = new Matrix();
			entity.add( point );
			entity.add( matrix );
			
			var nodes : NodeList = game.getNodeList( MockNode );
			game.addEntity( entity );
			assertThat( nodes.head.point, sameInstance( point ) );
			assertThat( nodes.head.matrix, sameInstance( matrix ) );
		}

		[Test]
		public function testCorrectEntityAddedToFamilyWhenAccessFamilyFirst() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			entity.add( new Matrix() );
			var nodes : NodeList = game.getNodeList( MockNode );
			game.addEntity( entity );
			assertThat( nodes.head.entity, sameInstance( entity ) );
		}

		[Test]
		public function testCorrectEntityAddedToFamilyWhenAccessFamilySecond() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			entity.add( new Matrix() );
			game.addEntity( entity );
			var nodes : NodeList = game.getNodeList( MockNode );
			assertThat( nodes.head.entity, sameInstance( entity ) );
		}

		[Test]
		public function testCorrectEntityAddedToFamilyWhenComponentsAdded() : void
		{
			var entity : Entity = new Entity();
			game.addEntity( entity );
			var nodes : NodeList = game.getNodeList( MockNode );
			entity.add( new Point() );
			entity.add( new Matrix() );
			assertThat( nodes.head.entity, sameInstance( entity ) );
		}
		
		[Test]
		public function testIncorrectEntityNotAddedToFamilyWhenAccessFamilyFirst() : void
		{
			var entity : Entity = new Entity();
			var nodes : NodeList = game.getNodeList( MockNode );
			game.addEntity( entity );
			assertThat( nodes.head, nullValue() );
		}
		
		[Test]
		public function testIncorrectEntityNotAddedToFamilyWhenAccessFamilySecond() : void
		{
			var entity : Entity = new Entity();
			game.addEntity( entity );
			var nodes : NodeList = game.getNodeList( MockNode );
			assertThat( nodes.head, nullValue() );
		}

		[Test]
		public function testEntityRemovedFromFamilyWhenComponentRemovedAndFamilyAlreadyAccessed() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			entity.add( new Matrix() );
			game.addEntity( entity );
			var nodes : NodeList = game.getNodeList( MockNode );
			entity.remove( Point );
			assertThat( nodes.head, nullValue() );
		}

		[Test]
		public function testEntityRemovedFromFamilyWhenComponentRemovedAndFamilyNotAlreadyAccessed() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			entity.add( new Matrix() );
			game.addEntity( entity );
			entity.remove( Point );
			var nodes : NodeList = game.getNodeList( MockNode );
			assertThat( nodes.head, nullValue() );
		}

		[Test]
		public function testEntityRemovedFromFamilyWhenRemovedFromGameAndFamilyAlreadyAccessed() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			entity.add( new Matrix() );
			game.addEntity( entity );
			var nodes : NodeList = game.getNodeList( MockNode );
			game.removeEntity( entity );
			assertThat( nodes.head, nullValue() );
		}

		[Test]
		public function testEntityRemovedFromFamilyWhenRemovedFromGameAndFamilyNotAlreadyAccessed() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			entity.add( new Matrix() );
			game.addEntity( entity );
			game.removeEntity( entity );
			var nodes : NodeList = game.getNodeList( MockNode );
			assertThat( nodes.head, nullValue() );
		}

		[Test]
		public function familyContainsOnlyMatchingEntities() : void
		{
			var entities : Array = new Array();
			for( var i : int = 0; i < 5; ++i )
			{
				var entity : Entity = new Entity();
				entity.add( new Point() );
				entity.add( new Matrix() );
				entities.push( entity );
				game.addEntity( entity );
			}
			
			var nodes : NodeList = game.getNodeList( MockNode );
			var node : MockNode;
			for( node = nodes.head; node; node = node.next )
			{
				assertThat( entities, hasItem( node.entity ) );
			}
		}

		[Test]
		public function familyContainsAllMatchingEntities() : void
		{
			var entities : Array = new Array();
			for( var i : int = 0; i < 5; ++i )
			{
				var entity : Entity = new Entity();
				entity.add( new Point() );
				entity.add( new Matrix() );
				entities.push( entity );
				game.addEntity( entity );
			}
			
			var nodes : NodeList = game.getNodeList( MockNode );
			var node : MockNode;
			for( node = nodes.head; node; node = node.next )
			{
				var index : int = entities.indexOf( node.entity );
				entities.splice( index, 1 );
			}
			assertThat( entities, emptyArray() );
		}
		
		[Test]
		public function releaseFamilyEmptiesNodeList() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			entity.add( new Matrix() );
			game.addEntity( entity );
			var nodes : NodeList = game.getNodeList( MockNode );
			game.releaseNodeList( MockNode );
			assertThat( nodes.head, nullValue() );
		}

		[Test]
		public function releaseFamilySetsNextNodeToNull() : void
		{
			var entities : Array = new Array();
			for( var i : int = 0; i < 5; ++i )
			{
				var entity : Entity = new Entity();
				entity.add( new Point() );
				entity.add( new Matrix() );
				entities.push( entity );
				game.addEntity( entity );
			}
			
			var nodes : NodeList = game.getNodeList( MockNode );
			var node : MockNode = nodes.head.next;
			game.releaseNodeList( MockNode );
			assertThat( node.next, nullValue() );
		}
		
		[Test]
		public function removeAllEntitiesDoesWhatItSays() : void
		{
			var entity : Entity = new Entity();
			entity.add( new Point() );
			entity.add( new Matrix() );
			game.addEntity( entity );
			entity = new Entity();
			entity.add( new Point() );
			entity.add( new Matrix() );
			game.addEntity( entity );
			var nodes : NodeList = game.getNodeList( MockNode );
			game.removeAllEntities();
			assertThat( nodes.head, nullValue() );
		}
	}
}
import net.richardlord.ash.core.Node;

import flash.geom.Matrix;
import flash.geom.Point;

class MockNode extends Node
{
	public var point : Point;
	public var matrix : Matrix;
}