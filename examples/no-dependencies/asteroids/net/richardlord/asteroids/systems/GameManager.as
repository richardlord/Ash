package net.richardlord.asteroids.systems
{
	import flash.geom.Point;
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.components.GameState;
	import net.richardlord.asteroids.nodes.AsteroidCollisionNode;
	import net.richardlord.asteroids.nodes.BulletCollisionNode;
	import net.richardlord.asteroids.nodes.SpaceshipCollisionNode;


	public class GameManager extends System
	{
		private var gameState : GameState;
		private var creator : EntityCreator;
		
		private var spaceships : NodeList;
		private var asteroids : NodeList;
		private var bullets : NodeList;

		public function GameManager( gameState : GameState, creator : EntityCreator )
		{
			this.gameState = gameState;
			this.creator = creator;
		}

		override public function addToGame( game : Game ) : void
		{
			spaceships = game.getNodeList( SpaceshipCollisionNode );
			asteroids = game.getNodeList( AsteroidCollisionNode );
			bullets = game.getNodeList( BulletCollisionNode );
		}
		
		override public function update( time : Number ) : void
		{
			if( spaceships.empty )
			{
				if( gameState.lives > 0 )
				{
					var newSpaceshipPosition : Point = new Point( gameState.width * 0.5, gameState.height * 0.5 );
					var clearToAddSpaceship : Boolean = true;
					for( var asteroid : AsteroidCollisionNode = asteroids.head; asteroid; asteroid = asteroid.next )
					{
						if( Point.distance( asteroid.position.position, newSpaceshipPosition ) <= asteroid.position.collisionRadius + 50 )
						{
							clearToAddSpaceship = false;
							break;
						}
					}
					if( clearToAddSpaceship )
					{
						creator.createSpaceship();
						gameState.lives--;
					}
				}
				else
				{
					// game over
				}
			}
			
			if( asteroids.empty && bullets.empty && !spaceships.empty )
			{
				// next level
				var spaceship : SpaceshipCollisionNode = spaceships.head;
				gameState.level++;
				var asteroidCount : int = 2 + gameState.level;
				for( var i:int = 0; i < asteroidCount; ++i )
				{
					// check not on top of spaceship
					do
					{
						var position : Point = new Point( Math.random() * gameState.width, Math.random() * gameState.height );
					}
					while ( Point.distance( position, spaceship.position.position ) <= 80 );
					creator.createAsteroid( 30, position.x, position.y );
				}
			}
		}

		override public function removeFromGame( game : Game ) : void
		{
			spaceships = null;
			asteroids = null;
			bullets = null;
		}
	}
}
