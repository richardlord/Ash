package net.richardlord.asteroids.nodes
{
	import net.richardlord.ash.core.Node;
	import net.richardlord.asteroids.components.Motion;
	import net.richardlord.asteroids.components.MotionControls;
	import net.richardlord.asteroids.components.Position;

	public class MotionControlNode extends Node
	{
		public var control : MotionControls;
		public var position : Position;
		public var motion : Motion;
	}
}
