package net.richardlord.ash.core
{
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.object.equalTo;

	import flash.geom.Point;
	
	public class GameTests
	{
		private var game : Game;
		
		[Before]
		public function createGame() : void
		{
			game = new Game();
			game.familyClass = MockFamily;
			MockFamily.reset();
		}

		[After]
		public function clearGame() : void
		{
			game = null;
		}

		[Test]
		public function entitiesGetterReturnsAllTheEntities() : void
		{
			var entity1 : Entity = new Entity();
			game.addEntity( entity1 );
			var entity2 : Entity = new Entity();
			game.addEntity( entity2 );
			assertThat( game.entities.length, equalTo( 2 ) );
			assertThat( game.entities, hasItems( entity1, entity2 ) );
		}

		[Test]
		public function addEntityChecksWithAllFamilies() : void
		{
			game.getNodeList( MockNode );
			game.getNodeList( MockNode2 );
			var entity : Entity = new Entity();
			game.addEntity( entity );
			assertThat( MockFamily.instances[0].newEntityCalls, equalTo( 1 ) );
			assertThat( MockFamily.instances[1].newEntityCalls, equalTo( 1 ) );
		}

		[Test]
		public function removeEntityChecksWithAllFamilies() : void
		{
			game.getNodeList( MockNode );
			game.getNodeList( MockNode2 );
			var entity : Entity = new Entity();
			game.addEntity( entity );
			game.removeEntity( entity );
			assertThat( MockFamily.instances[0].removeEntityCalls, equalTo( 1 ) );
			assertThat( MockFamily.instances[1].removeEntityCalls, equalTo( 1 ) );
		}

		[Test]
		public function removeAllEntitiesChecksWithAllFamilies() : void
		{
			game.getNodeList( MockNode );
			game.getNodeList( MockNode2 );
			var entity : Entity = new Entity();
			var entity2 : Entity = new Entity();
			game.addEntity( entity );
			game.addEntity( entity2 );
			game.removeAllEntities();
			assertThat( MockFamily.instances[0].removeEntityCalls, equalTo( 2 ) );
			assertThat( MockFamily.instances[1].removeEntityCalls, equalTo( 2 ) );
		}
		
		[Test]
		public function componentAddedChecksWithAllFamilies() : void
		{
			game.getNodeList( MockNode );
			game.getNodeList( MockNode2 );
			var entity : Entity = new Entity();
			game.addEntity( entity );
			entity.add( new Point() );
			assertThat( MockFamily.instances[0].componentAddedCalls, equalTo( 1 ) );
			assertThat( MockFamily.instances[1].componentAddedCalls, equalTo( 1 ) );
		}
		
		[Test]
		public function componentRemovedChecksWithAllFamilies() : void
		{
			game.getNodeList( MockNode );
			game.getNodeList( MockNode2 );
			var entity : Entity = new Entity();
			game.addEntity( entity );
			entity.add( new Point() );
			entity.remove( Point );
			assertThat( MockFamily.instances[0].componentAddedCalls, equalTo( 1 ) );
			assertThat( MockFamily.instances[1].componentAddedCalls, equalTo( 1 ) );
		}

		[Test]
		public function getNodeListCreatesFamily() : void
		{
			game.getNodeList( MockNode );
			assertThat( MockFamily.instances.length, equalTo( 1 ) );
		}

		[Test]
		public function getNodeListChecksAllEntities() : void
		{
			game.addEntity( new Entity() );
			game.addEntity( new Entity() );
			game.getNodeList( MockNode );
			assertThat( MockFamily.instances[0].newEntityCalls, equalTo( 2 ) );
		}

		[Test]
		public function releaseNodeListCallsCleanUp() : void
		{
			game.getNodeList( MockNode );
			game.releaseNodeList( MockNode );
			assertThat( MockFamily.instances[0].cleanUpCalls, equalTo( 1 ) );
		}
	}
}
import net.richardlord.ash.core.Entity;
import net.richardlord.ash.core.Family;
import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.Node;
import net.richardlord.ash.core.NodeList;

import flash.geom.Matrix;
import flash.geom.Point;

class MockNode extends Node
{
	public var point : Point;
}

class MockNode2 extends Node
{
	public var matrix : Matrix;
}

class MockFamily implements Family
{
	public static function reset() : void
	{
		instances = new Vector.<MockFamily>();
	}
	public static var instances : Vector.<MockFamily> = new Vector.<MockFamily>();
	
	public var newEntityCalls : int = 0;
	public var removeEntityCalls : int = 0;
	public var componentAddedCalls : int = 0;
	public var componentRemovedCalls : int = 0;
	public var cleanUpCalls : int = 0;
	
	public function MockFamily( nodeClass : Class, game : Game )
	{
		instances.push( this );
	}
	
	public function get nodeList() : NodeList
	{
		return null;
	}
	public function newEntity( entity : Entity ) : void
	{
		newEntityCalls++;
	}
	public function removeEntity( entity : Entity ) : void
	{
		removeEntityCalls++;
	}
	public function componentAddedToEntity( entity : Entity, componentClass : Class ) : void
	{
		componentAddedCalls++;
	}
	public function componentRemovedFromEntity( entity : Entity, componentClass : Class ) : void
	{
		componentRemovedCalls++;
	}
	public function cleanUp() : void
	{
		cleanUpCalls++;
	}
}