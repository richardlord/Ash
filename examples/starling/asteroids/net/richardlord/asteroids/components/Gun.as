package net.richardlord.asteroids.components
{
	import flash.geom.Point;
	
	public class Gun
	{
		public var shooting : Boolean = false;
		public var offsetFromParent : Point;
		public var timeSinceLastShot : Number = 0;
		public var minimumShotInterval : Number = 0;
		public var bulletLifetime : Number = 0;
		
		public function Gun( offsetX : Number, offsetY : Number, minimumShotInterval : Number, bulletLifetime : Number )
		{
			offsetFromParent = new Point( offsetX, offsetY );
			this.minimumShotInterval = minimumShotInterval;
			this.bulletLifetime = bulletLifetime;
		}
	}
}
