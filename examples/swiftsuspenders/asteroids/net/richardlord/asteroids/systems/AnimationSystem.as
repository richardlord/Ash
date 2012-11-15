package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.nodes.AnimationNode;

	public class AnimationSystem extends System
	{
		[Inject(nodeType="net.richardlord.asteroids.nodes.AnimationNode")]
		public var nodes : NodeList;
		
		override public function update( time : Number ) : void
		{
			var node : AnimationNode;
			for ( node = nodes.head; node; node = node.next )
			{
				node.animation.animation.animate( time );
			}
		}
	}
}
