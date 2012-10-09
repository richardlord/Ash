package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.tools.ListIteratingSystem;
	import net.richardlord.asteroids.components.Motion;
	import net.richardlord.asteroids.components.MotionControls;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.MotionControlNode;
	import net.richardlord.input.KeyPoll;

	public class MotionControlSystem extends ListIteratingSystem
	{
		private var keyPoll : KeyPoll;
		
		public function MotionControlSystem( keyPoll : KeyPoll )
		{
			super( MotionControlNode, updateNode );
			this.keyPoll = keyPoll;
		}

		private function updateNode( node : MotionControlNode, time : Number ) : void
		{
			var control : MotionControls = node.control;
			var position : Position = node.position;
			var motion : Motion = node.motion;

			if ( keyPoll.isDown( control.left ) )
			{
				position.rotation -= control.rotationRate * time;
			}

			if ( keyPoll.isDown( control.right ) )
			{
				position.rotation += control.rotationRate * time;
			}

			if ( keyPoll.isDown( control.accelerate ) )
			{
				motion.velocity.x += Math.cos( position.rotation ) * control.accelerationRate * time;
				motion.velocity.y += Math.sin( position.rotation ) * control.accelerationRate * time;
			}
		}
	}
}
