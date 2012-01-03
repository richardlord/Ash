package net.richardlord.asteroids.components
{
	import flash.geom.Point;
	
	public class Gun
	{
		public var shooting : Boolean = false;
		public var offsetFromParent : Point = new Point();
		public var timeSinceLastShot : Number = 0;
		public var minimumShotInterval : Number = 0;
		public var bulletLifetime : Number = 0;
	}
}
