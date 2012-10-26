package net.richardlord.asteroids
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.fsm.EntityStateMachineSystem;
	import net.richardlord.ash.tick.FrameTickProvider;
	import net.richardlord.asteroids.systems.AnimationSystem;
	import net.richardlord.asteroids.systems.BulletAgeSystem;
	import net.richardlord.asteroids.systems.CollisionSystem;
	import net.richardlord.asteroids.systems.DeathThroesSystem;
	import net.richardlord.asteroids.systems.GameManager;
	import net.richardlord.asteroids.systems.GunControlSystem;
	import net.richardlord.asteroids.systems.MotionControlSystem;
	import net.richardlord.asteroids.systems.MovementSystem;
	import net.richardlord.asteroids.systems.RenderSystem;
	import net.richardlord.asteroids.systems.SystemPriorities;
	import net.richardlord.input.KeyPoll;

	import flash.display.DisplayObjectContainer;

	public class Asteroids
	{
		private var container : DisplayObjectContainer;
		private var game : Game;
		private var tickProvider : FrameTickProvider;
		private var creator : EntityCreator;
		private var keyPoll : KeyPoll;
		private var config : GameConfig;
		
		public function Asteroids( container : DisplayObjectContainer, width : Number, height : Number )
		{
			this.container = container;
			prepare( width, height );
		}
		
		private function prepare( width : Number, height : Number ) : void
		{
			game = new Game();
			creator = new EntityCreator( game );
			keyPoll = new KeyPoll( container.stage );
			config = new GameConfig();
			config.width = width;
			config.height = height;

			game.addSystem( new GameManager( creator, config ), SystemPriorities.preUpdate );
			game.addSystem( new MotionControlSystem( keyPoll ), SystemPriorities.update );
			game.addSystem( new GunControlSystem( keyPoll, creator ), SystemPriorities.update );
			game.addSystem( new BulletAgeSystem( creator ), SystemPriorities.update );
			game.addSystem( new DeathThroesSystem( creator ), SystemPriorities.update );
			game.addSystem( new MovementSystem( config ), SystemPriorities.move );
			game.addSystem( new CollisionSystem( creator ), SystemPriorities.resolveCollisions );
			game.addSystem( new AnimationSystem(), SystemPriorities.animate );
			game.addSystem( new RenderSystem( container ), SystemPriorities.render );
			game.addSystem( new EntityStateMachineSystem(), SystemPriorities.stateMachines );
			
			creator.createGame();
		}
		
		public function start() : void
		{
			tickProvider = new FrameTickProvider( container );
			tickProvider.add( game.update );
			tickProvider.start();
		}
	}
}
