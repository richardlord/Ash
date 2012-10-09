package net.richardlord.asteroids.components
{
	import flash.geom.Point;
	
	public class Position
	{
		public var position : Point;
		public var rotation : Number = 0;
		public var collisionRadius : Number = 0;
		
		public function Position( x : Number, y : Number, rotation : Number, collisionRadius : Number )
		{
			position = new Point( x, y );
			this.rotation = rotation;
			this.collisionRadius = collisionRadius;
		}
	}
}
