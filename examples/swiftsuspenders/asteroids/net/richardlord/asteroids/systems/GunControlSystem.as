package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.components.Gun;
	import net.richardlord.asteroids.components.GunControls;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.GunControlNode;
	import net.richardlord.input.KeyPoll;

	public class GunControlSystem extends System
	{
		[Inject]
		public var keyPoll : KeyPoll;
		[Inject]
		public var creator : EntityCreator;
		
		[Inject(nodeType="net.richardlord.asteroids.nodes.GunControlNode")]
		public var nodes : NodeList;

		override public function update( time : Number ) : void
		{
			var node : GunControlNode;
			var control : GunControls;
			var position : Position;
			var gun : Gun;

			for ( node = nodes.head; node; node = node.next )
			{
				control = node.control;
				gun = node.gun;
				position = node.position;

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
}
