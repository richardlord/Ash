package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.components.Bullet;
	import net.richardlord.asteroids.nodes.BulletAgeNode;

	public class BulletAgeSystem extends System
	{
		private var creator : EntityCreator;
		
		private var nodes : NodeList;

		public function BulletAgeSystem( creator : EntityCreator )
		{
			this.creator = creator;
			priority = SystemPriorities.update;
		}

		override public function addToGame( game : Game ) : void
		{
			nodes = game.getFamily( BulletAgeNode );
		}
		
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

		override public function removeFromGame( game : Game ) : void
		{
			nodes = null;
		}
	}
}
