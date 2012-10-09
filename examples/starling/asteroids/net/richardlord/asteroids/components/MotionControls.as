package net.richardlord.asteroids.components
{
	public class MotionControls
	{
		public var left : uint = 0;
		public var right : uint = 0;
		public var accelerate : uint = 0;
		
		public var accelerationRate : Number = 0;
		public var rotationRate : Number = 0;
		
		public function MotionControls( left : uint, right : uint, accelerate : uint, accelerationRate : Number, rotationRate : Number )
		{
			this.left = left;
			this.right = right;
			this.accelerate = accelerate;
			this.accelerationRate = accelerationRate;
			this.rotationRate = rotationRate;
		}
	}
}
