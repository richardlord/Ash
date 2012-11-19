package net.richardlord.asteroids.nodes
{
	import ash.core.Node;

	import net.richardlord.asteroids.components.Collision;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.components.Spaceship;

	public class SpaceshipCollisionNode extends Node
	{
		public var spaceship : Spaceship;
		public var position : Position;
		public var collision : Collision;
	}
}
