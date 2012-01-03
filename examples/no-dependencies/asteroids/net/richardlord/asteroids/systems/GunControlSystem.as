package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.components.Gun;
	import net.richardlord.asteroids.components.GunControls;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.GunControlNode;
	import net.richardlord.utils.KeyPoll;

	public class GunControlSystem extends System
	{
		private var keyPoll : KeyPoll;
		private var creator : EntityCreator;
		
		private var nodes : NodeList;

		public function GunControlSystem( keyPoll : KeyPoll, creator : EntityCreator )
		{
			this.keyPoll = keyPoll;
			this.creator = creator;
			priority = SystemPriorities.update;
		}

		override public function addToGame( game : Game ) : void
		{
			nodes = game.getFamily( GunControlNode );
		}
		
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

		override public function removeFromGame( game : Game ) : void
		{
			nodes = null;
		}
	}
}
