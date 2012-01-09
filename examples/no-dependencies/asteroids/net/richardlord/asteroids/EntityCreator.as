package net.richardlord.asteroids
{
	import flash.ui.Keyboard;
	import net.richardlord.ash.core.Entity;
	import net.richardlord.ash.core.Game;
	import net.richardlord.asteroids.components.Asteroid;
	import net.richardlord.asteroids.components.Bullet;
	import net.richardlord.asteroids.components.Display;
	import net.richardlord.asteroids.components.Gun;
	import net.richardlord.asteroids.components.GunControls;
	import net.richardlord.asteroids.components.Motion;
	import net.richardlord.asteroids.components.MotionControls;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.components.Spaceship;
	import net.richardlord.asteroids.graphics.AsteroidView;
	import net.richardlord.asteroids.graphics.BulletView;
	import net.richardlord.asteroids.graphics.SpaceshipView;


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

		public function createAsteroid( radius : Number, x : Number, y : Number ) : Entity
		{
			var asteroid : Entity = new Entity();

			asteroid.add( new Asteroid() );

			var position : Position = new Position();
			position.position.x = x;
			position.position.y = y;
			position.collisionRadius = radius;
			asteroid.add( position );

			var motion : Motion = new Motion();
			motion.angularVelocity = Math.random() * 2 - 1;
			motion.velocity.x = ( Math.random() - 0.5 ) * 4 * ( 50 - radius );
			motion.velocity.y = ( Math.random() - 0.5 ) * 4 * ( 50 - radius );
			asteroid.add( motion );

			var display : Display = new Display();
			display.displayObject = new AsteroidView( radius );
			asteroid.add( display );

			game.addEntity( asteroid );
			return asteroid;
		}

		public function createSpaceship() : Entity
		{
			var spaceship : Entity = new Entity();

			spaceship.add( new Spaceship() );

			var position : Position = new Position();
			position.position.x = 300;
			position.position.y = 225;
			position.collisionRadius = 6;
			spaceship.add( position );

			var motion : Motion = new Motion();
			motion.damping = 15;
			spaceship.add( motion );

			var motionControls : MotionControls = new MotionControls();
			motionControls.left = Keyboard.LEFT;
			motionControls.right = Keyboard.RIGHT;
			motionControls.accelerate = Keyboard.UP;
			motionControls.accelerationRate = 100;
			motionControls.rotationRate = 3;
			spaceship.add( motionControls );

			var gun : Gun = new Gun();
			gun.minimumShotInterval = 0.3;
			gun.offsetFromParent.x = 8;
			gun.offsetFromParent.y = 0;
			gun.bulletLifetime = 2;
			spaceship.add( gun );

			var gunControls : GunControls = new GunControls();
			gunControls.trigger = Keyboard.Z;
			spaceship.add( gunControls );

			var display : Display = new Display();
			display.displayObject = new SpaceshipView();
			spaceship.add( display );
			
			game.addEntity( spaceship );
			return spaceship;
		}

		public function createUserBullet( gun : Gun, parentPosition : Position ) : Entity
		{
			var bullet : Entity = new Entity();

			var userBullet : Bullet = new Bullet();
			userBullet.lifeRemaining = gun.bulletLifetime;
			bullet.add( userBullet );

			var cos : Number = Math.cos( parentPosition.rotation );
			var sin : Number = Math.sin( parentPosition.rotation );

			var bulletPosition : Position = new Position();
			bulletPosition.position.x = cos * gun.offsetFromParent.x - sin * gun.offsetFromParent.y + parentPosition.position.x;
			bulletPosition.position.y = sin * gun.offsetFromParent.x + cos * gun.offsetFromParent.y + parentPosition.position.y;
			bullet.add( bulletPosition );

			var motion : Motion = new Motion();
			motion.velocity.x = cos * 150;
			motion.velocity.y = sin * 150;
			bullet.add( motion );

			var display : Display = new Display();
			display.displayObject = new BulletView();
			bullet.add( display );

			game.addEntity( bullet );
			return bullet;
		}
	}
}
