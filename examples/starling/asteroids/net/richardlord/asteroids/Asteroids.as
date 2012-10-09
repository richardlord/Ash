package net.richardlord.asteroids
{
	import flash.geom.Rectangle;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.integration.starling.StarlingFrameTickProvider;
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
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Event;



	public class Asteroids extends Sprite
	{
		private var game : Game;
		private var tickProvider : StarlingFrameTickProvider;
		private var gameState : GameState;
		private var creator : EntityCreator;
		private var keyPoll : KeyPoll;
		
		public function Asteroids()
		{
			addEventListener( Event.ADDED_TO_STAGE, startGame );
		}
		
		private function startGame( event : Event ) : void
		{
			prepare();
			start();
		}
		
		private function prepare() : void
		{
			var viewPort : Rectangle = Starling.current.viewPort;
			game = new Game();
			gameState = new GameState( viewPort.width, viewPort.height );
			creator = new EntityCreator( game );
			keyPoll = new KeyPoll( Starling.current.nativeStage );

			game.addSystem( new GameManager( gameState, creator ), SystemPriorities.preUpdate );
			game.addSystem( new MotionControlSystem( keyPoll ), SystemPriorities.update );
			game.addSystem( new GunControlSystem( keyPoll, creator ), SystemPriorities.update );
			game.addSystem( new BulletAgeSystem( creator ), SystemPriorities.update );
			game.addSystem( new MovementSystem( gameState ), SystemPriorities.move );
			game.addSystem( new CollisionSystem( creator ), SystemPriorities.resolveCollisions );
			game.addSystem( new RenderSystem( this ), SystemPriorities.render );

			tickProvider = new StarlingFrameTickProvider( Starling.current.juggler );
		}
		
		private function start() : void
		{
			gameState.level = 0;
			gameState.lives = 3;
			gameState.points = 0;

			tickProvider.add( game.update );
			tickProvider.start();
		}
	}
}
