package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.tools.ListIteratingSystem;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.components.Gun;
	import net.richardlord.asteroids.components.GunControls;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.GunControlNode;
	import net.richardlord.input.KeyPoll;

	public class GunControlSystem extends ListIteratingSystem
	{
		private var keyPoll : KeyPoll;
		private var creator : EntityCreator;
		
		public function GunControlSystem( keyPoll : KeyPoll, creator : EntityCreator )
		{
			super( GunControlNode, updateNode );
			this.keyPoll = keyPoll;
			this.creator = creator;
		}

		private function updateNode( node : GunControlNode, time : Number ) : void
		{
			var control : GunControls = node.control;
			var position : Position = node.position;
			var gun : Gun = node.gun;

			gun.shooting = keyPoll.isDown( control.trigger );
			gun.timeSinceLastShot += time;
			if ( gun.shooting && gun.timeSinceLastShot >= gun.minimumShotInterval )
			{
				creator.createUserBullet( gun, position );
				gun.timeSinceLastShot = 0;
			}
		}
	}
}
