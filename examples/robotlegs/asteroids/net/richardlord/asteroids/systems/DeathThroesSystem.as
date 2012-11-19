package net.richardlord.asteroids.systems
{
	import ash.core.NodeList;
	import ash.core.System;

	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.nodes.DeathThroesNode;

	public class DeathThroesSystem extends System
	{
		[Inject]
		public var creator : EntityCreator;
		
		[Inject(nodeType="net.richardlord.asteroids.nodes.DeathThroesNode")]
		public var nodes : NodeList;
		
		override public function update( time : Number ) : void
		{
			var node : DeathThroesNode;
			for ( node = nodes.head; node; node = node.next )
			{
				node.death.countdown -= time;
				if ( node.death.countdown <= 0 )
				{
					creator.destroyEntity( node.entity );
				}
			}
		}
	}
}
