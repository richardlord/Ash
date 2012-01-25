package net.richardlord.asteroids
{
	import flash.display.DisplayObjectContainer;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.integration.swiftsuspenders.SwiftSuspendersGame;
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
	import org.swiftsuspenders.Injector;



	public class Asteroids
	{
		private var game : Game;
		private var tickProvider : FrameTickProvider;
		private var injector : Injector;
		
		public function Asteroids( container : DisplayObjectContainer, width : Number, height : Number )
		{
			prepare( container, width, height );
		}
		
		private function prepare( container : DisplayObjectContainer, width : Number, height : Number ) : void
		{
			injector = new Injector();
			game = new SwiftSuspendersGame( injector );
			
			injector.map( Game ).toValue( game );
			injector.map( DisplayObjectContainer ).toValue( container );
			injector.map( GameState ).asSingleton();
			injector.map( EntityCreator ).asSingleton();
			injector.map( KeyPoll ).toValue( new KeyPoll( container.stage ) );
			
			game.addSystem( new GameManager(), SystemPriorities.preUpdate );
			game.addSystem( new MotionControlSystem(), SystemPriorities.update );
			game.addSystem( new GunControlSystem(), SystemPriorities.update );
			game.addSystem( new BulletAgeSystem(), SystemPriorities.update );
			game.addSystem( new MovementSystem(), SystemPriorities.move );
			game.addSystem( new CollisionSystem(), SystemPriorities.resolveCollisions );
			game.addSystem( new RenderSystem(), SystemPriorities.render );
			
			tickProvider = new FrameTickProvider( container );
			
			var gameState : GameState = injector.getInstance( GameState );
			gameState.width = width;
			gameState.height = height;
		}
		
		public function start() : void
		{
			var gameState : GameState = injector.getInstance( GameState );
			
			gameState.level = 0;
			gameState.lives = 3;
			gameState.points = 0;

			tickProvider.add( game.update );
			tickProvider.start();
		}
	}
}
