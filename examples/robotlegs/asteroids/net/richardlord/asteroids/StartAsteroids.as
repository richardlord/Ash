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
	import net.richardlord.utils.KeyPoll;

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
			
			game.addSystemWithPriority( new GameManager(), SystemPriorities.preUpdate );
			game.addSystemWithPriority( new MotionControlSystem(), SystemPriorities.update );
			game.addSystemWithPriority( new GunControlSystem(), SystemPriorities.update );
			game.addSystemWithPriority( new BulletAgeSystem(), SystemPriorities.update );
			game.addSystemWithPriority( new MovementSystem(), SystemPriorities.move );
			game.addSystemWithPriority( new CollisionSystem(), SystemPriorities.resolveCollisions );
			game.addSystemWithPriority( new RenderSystem(), SystemPriorities.render );
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
