package net.richardlord.asteroids.nodes
{
	import net.richardlord.ash.core.Node;
	import net.richardlord.asteroids.components.Asteroid;
	import net.richardlord.asteroids.components.Position;
	
	public class AsteroidCollisionNode extends Node
	{
		public var asteroid : Asteroid;
		public var position : Position;
	}
}
