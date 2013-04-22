package ash.core
{
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isNull;
	import org.hamcrest.object.nullValue;
	import org.hamcrest.object.sameInstance;

	import flash.geom.Point;

	public class EngineTests
	{
		private var engine : Engine;
		
		[Before]
		public function createEngine() : void
		{
			engine = new Engine();
			engine.familyClass = MockFamily;
			MockFamily.reset();
		}

		[After]
		public function clearEngine() : void
		{
			engine = null;
		}

		[Test]
		public function entitiesGetterReturnsAllTheEntities() : void
		{
			var entity1 : Entity = new Entity();
			engine.addEntity( entity1 );
			var entity2 : Entity = new Entity();
			engine.addEntity( entity2 );
			assertThat( engine.entities.length, equalTo( 2 ) );
			assertThat( engine.entities, hasItems( entity1, entity2 ) );
		}
		
		[Test]
		public function getEntityByNameReturnsCorrectEntity() : void
		{
			var entity1 : Entity = new Entity();
			entity1.name = "otherEntity";
			engine.addEntity( entity1 );
			var entity2 : Entity = new Entity();
			entity2.name = "myEntity";
			engine.addEntity( entity2 );
			assertThat( engine.getEntityByName( "myEntity" ), sameInstance( entity2 ) );
		}
		
		[Test]
		public function getEntityByNameReturnsNullIfNoEntity() : void
		{
			var entity1 : Entity = new Entity();
			entity1.name = "otherEntity";
			engine.addEntity( entity1 );
			var entity2 : Entity = new Entity();
			entity2.name = "myEntity";
			engine.addEntity( entity2 );
			assertThat( engine.getEntityByName( "wrongName" ), isNull() );
		}

		[Test]
		public function addEntityChecksWithAllFamilies() : void
		{
			engine.getNodeList( MockNode );
			engine.getNodeList( MockNode2 );
			var entity : Entity = new Entity();
			engine.addEntity( entity );
			assertThat( MockFamily.instances[0].newEntityCalls, equalTo( 1 ) );
			assertThat( MockFamily.instances[1].newEntityCalls, equalTo( 1 ) );
		}

		[Test]
		public function removeEntityChecksWithAllFamilies() : void
		{
			engine.getNodeList( MockNode );
			engine.getNodeList( MockNode2 );
			var entity : Entity = new Entity();
			engine.addEntity( entity );
			engine.removeEntity( entity );
			assertThat( MockFamily.instances[0].removeEntityCalls, equalTo( 1 ) );
			assertThat( MockFamily.instances[1].removeEntityCalls, equalTo( 1 ) );
		}

		[Test]
		public function removeAllEntitiesChecksWithAllFamilies() : void
		{
			engine.getNodeList( MockNode );
			engine.getNodeList( MockNode2 );
			var entity : Entity = new Entity();
			var entity2 : Entity = new Entity();
			engine.addEntity( entity );
			engine.addEntity( entity2 );
			engine.removeAllEntities();
			assertThat( MockFamily.instances[0].removeEntityCalls, equalTo( 2 ) );
			assertThat( MockFamily.instances[1].removeEntityCalls, equalTo( 2 ) );
		}
		
		[Test]
		public function componentAddedChecksWithAllFamilies() : void
		{
			engine.getNodeList( MockNode );
			engine.getNodeList( MockNode2 );
			var entity : Entity = new Entity();
			engine.addEntity( entity );
			entity.add( new Point() );
			assertThat( MockFamily.instances[0].componentAddedCalls, equalTo( 1 ) );
			assertThat( MockFamily.instances[1].componentAddedCalls, equalTo( 1 ) );
		}
		
		[Test]
		public function componentRemovedChecksWithAllFamilies() : void
		{
			engine.getNodeList( MockNode );
			engine.getNodeList( MockNode2 );
			var entity : Entity = new Entity();
			engine.addEntity( entity );
			entity.add( new Point() );
			entity.remove( Point );
			assertThat( MockFamily.instances[0].componentRemovedCalls, equalTo( 1 ) );
			assertThat( MockFamily.instances[1].componentRemovedCalls, equalTo( 1 ) );
		}

		[Test]
		public function getNodeListCreatesFamily() : void
		{
			engine.getNodeList( MockNode );
			assertThat( MockFamily.instances.length, equalTo( 1 ) );
		}

		[Test]
		public function getNodeListChecksAllEntities() : void
		{
			engine.addEntity( new Entity() );
			engine.addEntity( new Entity() );
			engine.getNodeList( MockNode );
			assertThat( MockFamily.instances[0].newEntityCalls, equalTo( 2 ) );
		}

		[Test]
		public function releaseNodeListCallsCleanUp() : void
		{
			engine.getNodeList( MockNode );
			engine.releaseNodeList( MockNode );
			assertThat( MockFamily.instances[0].cleanUpCalls, equalTo( 1 ) );
		}
		
		[Test]
		public function entityCanBeObtainedByName() : void
		{
			var entity : Entity = new Entity( "anything" );
			engine.addEntity( entity );
			var other : Entity = engine.getEntityByName( "anything" );
			assertThat( other, sameInstance( entity ) );
		}
		
		[Test]
		public function getEntityByInvalidNameReturnsNull() : void
		{
			var entity : Entity = engine.getEntityByName( "anything" );
			assertThat( entity, nullValue() );
		}
		
		[Test]
		public function entityCanBeObtainedByNameAfterRenaming() : void
		{
			var entity : Entity = new Entity( "anything" );
			engine.addEntity( entity );
			entity.name = "otherName";
			var other : Entity = engine.getEntityByName( "otherName" );
			assertThat( other, sameInstance( entity ) );
		}
		
		[Test]
		public function entityCannotBeObtainedByOldNameAfterRenaming() : void
		{
			var entity : Entity = new Entity( "anything" );
			engine.addEntity( entity );
			entity.name = "otherName";
			var other : Entity = engine.getEntityByName( "anything" );
			assertThat( other, nullValue() );
		}
	}
}
import ash.core.Engine;
import ash.core.Entity;
import ash.core.IFamily;
import ash.core.Node;
import ash.core.NodeList;

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

class MockFamily implements IFamily
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
	
	public function MockFamily( nodeClass : Class, engine : Engine )
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