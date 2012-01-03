package net.richardlord.asteroids.nodes
{
	import net.richardlord.ash.core.Node;
	import net.richardlord.asteroids.components.Bullet;
	import net.richardlord.asteroids.components.Position;

	public class BulletCollisionNode extends Node
	{
		public var bullet : Bullet;
		public var position : Position;
	}
}
