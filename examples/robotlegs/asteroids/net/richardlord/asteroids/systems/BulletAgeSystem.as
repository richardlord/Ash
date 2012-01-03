package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.components.Bullet;
	import net.richardlord.asteroids.nodes.BulletAgeNode;

	public class BulletAgeSystem extends System
	{
		[Inject]
		public var creator : EntityCreator;
		
		[Inject(nodeType="net.richardlord.asteroids.nodes.BulletAgeNode")]
		public var nodes : NodeList;

		override public function update( time : Number ) : void
		{
			var node : BulletAgeNode;
			var bullet : Bullet;

			for ( node = nodes.head; node; node = node.next )
			{
				bullet = node.bullet;

				bullet.lifeRemaining -= time;
				if ( bullet.lifeRemaining <= 0 )
				{
					creator.destroyEntity( node.entity );
				}
			}
		}
	}
}
