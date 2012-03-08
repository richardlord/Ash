package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.tools.ListIteratingSystem;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.components.Bullet;
	import net.richardlord.asteroids.nodes.BulletAgeNode;

	public class BulletAgeSystem extends ListIteratingSystem
	{
		private var creator : EntityCreator;
		
		public function BulletAgeSystem( creator : EntityCreator )
		{
			super( BulletAgeNode, updateNode );
			this.creator = creator;
		}

		private function updateNode( node : BulletAgeNode, time : Number ) : void
		{
			var bullet : Bullet = node.bullet;
			bullet.lifeRemaining -= time;
			if ( bullet.lifeRemaining <= 0 )
			{
				creator.destroyEntity( node.entity );
			}
		}
	}
}
