package net.richardlord.asteroids
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.integration.starling.StarlingFrameTickProvider;
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

	import flash.geom.Rectangle;

	public class Asteroids extends Sprite
	{
		private var game : Game;
		private var tickProvider : StarlingFrameTickProvider;
		private var creator : EntityCreator;
		private var keyPoll : KeyPoll;
		private var config : GameConfig;
		
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
			game = new Game();
			creator = new EntityCreator( game );
			keyPoll = new KeyPoll( Starling.current.nativeStage );
			var viewPort : Rectangle = Starling.current.viewPort;
			config = new GameConfig();
			config.width = viewPort.width;
			config.height = viewPort.height;

			game.addSystem( new GameManager( creator, config ), SystemPriorities.preUpdate );
			game.addSystem( new MotionControlSystem( keyPoll ), SystemPriorities.update );
			game.addSystem( new GunControlSystem( keyPoll, creator ), SystemPriorities.update );
			game.addSystem( new BulletAgeSystem( creator ), SystemPriorities.update );
			game.addSystem( new MovementSystem( config ), SystemPriorities.move );
			game.addSystem( new CollisionSystem( creator ), SystemPriorities.resolveCollisions );
			game.addSystem( new RenderSystem( this ), SystemPriorities.render );
			
			creator.createGame();
		}
		
		private function start() : void
		{
			tickProvider = new StarlingFrameTickProvider( Starling.current.juggler );
			tickProvider.add( game.update );
			tickProvider.start();
		}
	}
}
