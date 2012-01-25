package net.richardlord.asteroids
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.tick.FrameTickProvider;
	import net.richardlord.ash.tick.TickProvider;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.events.StartGameEvent;
	import net.richardlord.asteroids.systems.BulletAgeSystem;
	import net.richardlord.asteroids.systems.CollisionSystem;
	import net.richardlord.asteroids.systems.GameManager;
	import net.richardlord.asteroids.systems.GunControlSystem;
	import net.richardlord.asteroids.systems.MotionControlSystem;
	import net.richardlord.asteroids.systems.MovementSystem;
	import net.richardlord.asteroids.systems.RenderSystem;
	import net.richardlord.asteroids.systems.SystemPriorities;
	import net.richardlord.input.KeyPoll;
	import org.swiftsuspenders.Injector;


	public class StartAsteroids
	{
		[Inject]
		public var injector : Injector;
		[Inject]
		public var event : StartGameEvent;
		[Inject]
		public var game : Game;
		
		public function execute() : void
		{
			prepare();
			start();
		}
		
		private function prepare() : void
		{
			injector.map( GameState ).asSingleton();
			injector.map( EntityCreator ).asSingleton();
			injector.map( KeyPoll ).toValue( new KeyPoll( event.container.stage ) );
			injector.map( TickProvider ).toValue( new FrameTickProvider( event.container ) );
			
			game.addSystem( new GameManager(), SystemPriorities.preUpdate );
			game.addSystem( new MotionControlSystem(), SystemPriorities.update );
			game.addSystem( new GunControlSystem(), SystemPriorities.update );
			game.addSystem( new BulletAgeSystem(), SystemPriorities.update );
			game.addSystem( new MovementSystem(), SystemPriorities.move );
			game.addSystem( new CollisionSystem(), SystemPriorities.resolveCollisions );
			game.addSystem( new RenderSystem(), SystemPriorities.render );
		}
		
		public function start() : void
		{
			var gameState : GameState = injector.getInstance( GameState );
			
			gameState.level = 0;
			gameState.lives = 3;
			gameState.points = 0;
			gameState.width = event.width;
			gameState.height = event.height;

			var tickProvider : TickProvider = injector.getInstance( TickProvider );
			tickProvider.add( game.update );
			tickProvider.start();
		}
	}
}
