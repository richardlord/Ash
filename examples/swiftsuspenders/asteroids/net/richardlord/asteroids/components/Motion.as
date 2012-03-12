package net.richardlord.asteroids.components
{
	import flash.geom.Point;
	
	public class Motion
	{
		public var velocity : Point = new Point();
		public var angularVelocity : Number = 0;
		public var damping : Number = 0;
		
		public function Motion( velocityX : Number, velocityY : Number, angularVelocity : Number, damping : Number )
		{
			velocity = new Point( velocityX, velocityY );
			this.angularVelocity = angularVelocity;
			this.damping = damping;
		}
	}
}
