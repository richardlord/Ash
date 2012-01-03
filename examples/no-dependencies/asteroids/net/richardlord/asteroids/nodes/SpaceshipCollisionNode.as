package net.richardlord.asteroids.nodes
{
	import net.richardlord.ash.core.Node;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.components.Spaceship;

	public class SpaceshipCollisionNode extends Node
	{
		public var spaceship : Spaceship;
		public var position : Position;
	}
}
