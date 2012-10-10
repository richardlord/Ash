package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.EntityCreator;
	import net.richardlord.asteroids.GameConfig;
	import net.richardlord.asteroids.nodes.AsteroidCollisionNode;
	import net.richardlord.asteroids.nodes.BulletCollisionNode;
	import net.richardlord.asteroids.nodes.GameNode;
	import net.richardlord.asteroids.nodes.SpaceshipCollisionNode;

	import flash.geom.Point;

	public class GameManager extends System
	{
		private var config : GameConfig;
		private var creator : EntityCreator;
		
		private var gameNodes : NodeList;
		private var spaceships : NodeList;
		private var asteroids : NodeList;
		private var bullets : NodeList;

		public function GameManager( creator : EntityCreator, config : GameConfig )
		{
			this.creator = creator;
			this.config = config;
		}

		override public function addToGame( game : Game ) : void
		{
			gameNodes = game.getNodeList( GameNode );
			spaceships = game.getNodeList( SpaceshipCollisionNode );
			asteroids = game.getNodeList( AsteroidCollisionNode );
			bullets = game.getNodeList( BulletCollisionNode );
		}
		
		override public function update( time : Number ) : void
		{
			var node : GameNode;
			for( node = gameNodes.head; node; node = node.next )
			{
				if( spaceships.empty )
				{
					if( node.state.lives > 0 )
					{
						var newSpaceshipPosition : Point = new Point( config.width * 0.5, config.height * 0.5 );
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
							node.state.lives--;
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
					node.state.level++;
					var asteroidCount : int = 2 + node.state.level;
					for( var i:int = 0; i < asteroidCount; ++i )
					{
						// check not on top of spaceship
						do
						{
							var position : Point = new Point( Math.random() * config.width, Math.random() * config.height );
						}
						while ( Point.distance( position, spaceship.position.position ) <= 80 );
						creator.createAsteroid( 30, position.x, position.y );
					}
				}
			}
		}

		override public function removeFromGame( game : Game ) : void
		{
			gameNodes = null;
			spaceships = null;
			asteroids = null;
			bullets = null;
		}
	}
}
