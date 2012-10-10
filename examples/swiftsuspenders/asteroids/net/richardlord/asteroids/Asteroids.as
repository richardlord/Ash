package net.richardlord.asteroids
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.integration.swiftsuspenders.SwiftSuspendersGame;
	import net.richardlord.ash.tick.FrameTickProvider;
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

	import flash.display.DisplayObjectContainer;

	public class Asteroids
	{
		private var game : Game;
		private var tickProvider : FrameTickProvider;
		private var injector : Injector;
		private var container : DisplayObjectContainer;
		
		public function Asteroids( container : DisplayObjectContainer, width : Number, height : Number )
		{
			this.container = container;
			prepare( width, height );
		}
		
		private function prepare( width : Number, height : Number ) : void
		{
			injector = new Injector();
			game = new SwiftSuspendersGame( injector );
			
			injector.map( Game ).toValue( game );
			injector.map( DisplayObjectContainer ).toValue( container );
			injector.map( GameConfig ).asSingleton();
			injector.map( EntityCreator ).asSingleton();
			injector.map( KeyPoll ).toValue( new KeyPoll( container.stage ) );
			
			var config : GameConfig = injector.getInstance( GameConfig );
			config.width = width;
			config.height = height;
			
			game.addSystem( new GameManager(), SystemPriorities.preUpdate );
			game.addSystem( new MotionControlSystem(), SystemPriorities.update );
			game.addSystem( new GunControlSystem(), SystemPriorities.update );
			game.addSystem( new BulletAgeSystem(), SystemPriorities.update );
			game.addSystem( new MovementSystem(), SystemPriorities.move );
			game.addSystem( new CollisionSystem(), SystemPriorities.resolveCollisions );
			game.addSystem( new RenderSystem(), SystemPriorities.render );
			
			var creator : EntityCreator = injector.getInstance( EntityCreator );
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
