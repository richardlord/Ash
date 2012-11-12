package net.richardlord.asteroids
{
	import net.richardlord.ash.core.Entity;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.fsm.EntityStateMachine;
	import net.richardlord.asteroids.components.Animation;
	import net.richardlord.asteroids.components.Asteroid;
	import net.richardlord.asteroids.components.Bullet;
	import net.richardlord.asteroids.components.Collision;
	import net.richardlord.asteroids.components.DeathThroes;
	import net.richardlord.asteroids.components.Display;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.components.Gun;
	import net.richardlord.asteroids.components.GunControls;
	import net.richardlord.asteroids.components.Motion;
	import net.richardlord.asteroids.components.MotionControls;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.components.Spaceship;
	import net.richardlord.asteroids.graphics.AsteroidView;
	import net.richardlord.asteroids.graphics.BulletView;
	import net.richardlord.asteroids.graphics.SpaceshipDeathView;
	import net.richardlord.asteroids.graphics.SpaceshipView;

	import flash.ui.Keyboard;

	public class EntityCreator
	{
		private var game : Game;
		
		public function EntityCreator( game : Game )
		{
			this.game = game;
		}
		
		public function destroyEntity( entity : Entity ) : void
		{
			game.removeEntity( entity );
		}
		
		public function createGame() : Entity
		{
			var gameEntity : Entity = new Entity()
				.add( new GameState() );
			game.addEntity( gameEntity );
			return gameEntity;
		}

		public function createAsteroid( radius : Number, x : Number, y : Number ) : Entity
		{
			var asteroid : Entity = new Entity()
				.add( new Asteroid() )
				.add( new Position( x, y, 0 ) )
				.add( new Collision( radius ) )
				.add( new Motion( ( Math.random() - 0.5 ) * 4 * ( 50 - radius ), ( Math.random() - 0.5 ) * 4 * ( 50 - radius ), Math.random() * 2 - 1, 0 ) )
				.add( new Display( new AsteroidView( radius ) ) );
			game.addEntity( asteroid );
			return asteroid;
		}

		public function createSpaceship() : Entity
		{
			var spaceship : Entity = new Entity();
			var fsm : EntityStateMachine = new EntityStateMachine( spaceship );
			
			fsm.createState( "playing" )
				.add( Motion ).withInstance( new Motion( 0, 0, 0, 15 ) )
				.add( MotionControls ).withInstance( new MotionControls( Keyboard.LEFT, Keyboard.RIGHT, Keyboard.UP, 100, 3 ) )
				.add( Gun ).withInstance( new Gun( 8, 0, 0.3, 2 ) )
				.add( GunControls ).withInstance( new GunControls( Keyboard.SPACE ) )
				.add( Collision ).withInstance( new Collision( 9 ) )
				.add( Display ).withInstance( new Display( new SpaceshipView() ) );
			
			var deathView : SpaceshipDeathView = new SpaceshipDeathView();
			fsm.createState( "destroyed" )
				.add( DeathThroes ).withInstance( new DeathThroes( 5 ) )
				.add( Display ).withInstance( new Display( deathView ) )
				.add( Animation ).withInstance( new Animation( deathView ) );
			
			spaceship.add( new Spaceship( fsm ) ).add( new Position( 300, 225, 0 ) );
				
			fsm.changeState( "playing" );
			game.addEntity( spaceship );
			return spaceship;
		}

		public function createUserBullet( gun : Gun, parentPosition : Position ) : Entity
		{
			var cos : Number = Math.cos( parentPosition.rotation );
			var sin : Number = Math.sin( parentPosition.rotation );
			var bullet : Entity = new Entity()
				.add( new Bullet( gun.bulletLifetime ) )
				.add( new Position(
					cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x,
					sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y, 0 ) )
				.add( new Collision( 0 ) )
				.add( new Motion( cos * 150, sin * 150, 0, 0 ) )
				.add( new Display( new BulletView() ) );
			game.addEntity( bullet );
			return bullet;
		}
	}
}
