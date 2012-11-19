package net.richardlord.asteroids.components
{
	import ash.fsm.EntityStateMachine;

	public class Spaceship
	{
		public var fsm : EntityStateMachine;
		
		public function Spaceship( fsm : EntityStateMachine )
		{
			this.fsm = fsm;
		}
	}
}
