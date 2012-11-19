package ash.tools
{
	import ash.core.Entity;
	import ash.core.Ash;
	import flash.geom.Point;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;


	
	public class ListIteratingSystemTest
	{
		private var entities : Vector.<Entity>;
		private var callCount : int;
		
		[Test]
		public function updateIteratesOverNodes() : void
		{
			var game : Ash = new Ash();
			var entity1 : Entity = new Entity();
			var component1 : Point = new Point();
			entity1.add( component1 );
			game.addEntity( entity1 );
			var entity2 : Entity = new Entity();
			var component2 : Point = new Point();
			entity2.add( component2 );
			game.addEntity( entity2 );
			var entity3 : Entity = new Entity();
			var component3 : Point = new Point();
			entity3.add( component3 );
			game.addEntity( entity3 );
			
			var system : ListIteratingSystem = new ListIteratingSystem( MockNode, updateNode );
			game.addSystem( system, 1 );
			entities = new <Entity>[entity1, entity2, entity3];
			callCount = 0;
			game.update( 0.1 );
			assertThat( callCount, equalTo( 3 ) );
		}
		
		private function updateNode( node : MockNode, time : Number ) : void
		{
			assertThat( node.entity, equalTo( entities[callCount] ) );
			assertThat( time, equalTo( 0.1 ) );
			callCount++;
		}
	}
}

import ash.core.Node;
import flash.geom.Point;


class MockNode extends Node
{
	public var value : Point;
}