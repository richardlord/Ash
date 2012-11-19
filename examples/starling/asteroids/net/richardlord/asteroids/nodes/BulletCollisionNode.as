package net.richardlord.asteroids.nodes
{
	import ash.core.Node;

	import net.richardlord.asteroids.components.Bullet;
	import net.richardlord.asteroids.components.Collision;
	import net.richardlord.asteroids.components.Position;

	public class BulletCollisionNode extends Node
	{
		public var bullet : Bullet;
		public var position : Position;
		public var collision : Collision;
	}
}
