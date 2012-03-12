package net.richardlord.asteroids
{
	import flash.display.DisplayObjectContainer;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.tick.FrameTickProvider;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.systems.BulletAgeSystem;
	import net.richardlord.asteroids.systems.CollisionSystem;
	import net.richardlord.asteroids.systems.GameManager;
	import net.richardlord.asteroids.systems.GunControlSystem;
	import net.richardlord.asteroids.systems.MotionControlSystem;
	import net.richardlord.asteroids.systems.MovementSystem;
	import net.richardlord.asteroids.systems.RenderSystem;
	import net.richardlord.asteroids.systems.SystemPriorities;
	import net.richardlord.input.KeyPoll;



	public class Asteroids
	{
		private var container : DisplayObjectContainer;
		private var game : Game;
		private var tickProvider : FrameTickProvider;
		private var gameState : GameState;
		private var creator : EntityCreator;
		private var keyPoll : KeyPoll;
		private var width : Number;
		private var height : Number;
		
		public function Asteroids( container : DisplayObjectContainer, width : Number, height : Number )
		{
			this.container = container;
			this.width = width;
			this.height = height;
			prepare();
		}
		
		private function prepare() : void
		{
			game = new Game();
			gameState = new GameState( width, height );
			creator = new EntityCreator( game );
			keyPoll = new KeyPoll( container.stage );

			game.addSystem( new GameManager( gameState, creator ), SystemPriorities.preUpdate );
			game.addSystem( new MotionControlSystem( keyPoll ), SystemPriorities.update );
			game.addSystem( new GunControlSystem( keyPoll, creator ), SystemPriorities.update );
			game.addSystem( new BulletAgeSystem( creator ), SystemPriorities.update );
			game.addSystem( new MovementSystem(), SystemPriorities.move );
			game.addSystem( new CollisionSystem( creator ), SystemPriorities.resolveCollisions );
			game.addSystem( new RenderSystem( container ), SystemPriorities.render );

			tickProvider = new FrameTickProvider( container );
		}
		
		public function start() : void
		{
			gameState.level = 0;
			gameState.lives = 3;
			gameState.points = 0;

			tickProvider.add( game.update );
			tickProvider.start();
		}
	}
}
