package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.tools.ListIteratingSystem;
	import net.richardlord.asteroids.nodes.AnimationNode;

	public class AnimationSystem extends ListIteratingSystem
	{
		public function AnimationSystem()
		{
			super( AnimationNode, updateNode );
		}

		private function updateNode( node : AnimationNode, time : Number ) : void
		{
			node.animation.animation.animate( time );
		}
	}
}
