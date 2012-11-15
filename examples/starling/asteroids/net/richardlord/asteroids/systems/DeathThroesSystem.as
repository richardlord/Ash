package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.tools.ListIteratingSystem;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.nodes.DeathThroesNode;

	public class DeathThroesSystem extends ListIteratingSystem
	{
		private var creator : EntityCreator;
		
		public function DeathThroesSystem( creator : EntityCreator )
		{
			super( DeathThroesNode, updateNode );
			this.creator = creator;
		}

		private function updateNode( node : DeathThroesNode, time : Number ) : void
		{
			node.death.countdown -= time;
			if ( node.death.countdown <= 0 )
			{
				creator.destroyEntity( node.entity );
			}
		}
	}
}
