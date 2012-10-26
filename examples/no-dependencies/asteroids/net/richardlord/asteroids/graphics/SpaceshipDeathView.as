package net.richardlord.asteroids.graphics
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class SpaceshipDeathView extends Sprite implements Animatable
	{
		private var shape1 : Shape;
		private var shape2 : Shape;
		private var vel1 : Point;
		private var vel2 : Point;
		private var rot1 : Number;
		private var rot2 : Number;
		
		public function SpaceshipDeathView()
		{
			shape1 = new Shape();
			shape1.graphics.beginFill( 0xFFFFFF );
			shape1.graphics.moveTo( 10, 0 );
			shape1.graphics.lineTo( -7, 7 );
			shape1.graphics.lineTo( -4, 0 );
			shape1.graphics.lineTo( 10, 0 );
			shape1.graphics.endFill();
			addChild( shape1 );
			
			shape2 = new Shape();
			shape2.graphics.beginFill( 0xFFFFFF );
			shape2.graphics.moveTo( 10, 0 );
			shape2.graphics.lineTo( -7, -7 );
			shape2.graphics.lineTo( -4, 0 );
			shape2.graphics.lineTo( 10, 0 );
			shape2.graphics.endFill();
			addChild( shape2 );
			
			vel1 = new Point( Math.random() * 10 - 5, Math.random() * 10 + 10 );
			vel2 = new Point( Math.random() * 10 - 5, - ( Math.random() * 10 + 10 ) );
			
			rot1 = Math.random() * 300 - 150;
			rot2 = Math.random() * 300 - 150;
		}
		
		public function animate( time : Number ) : void
		{
			shape1.x += vel1.x * time;
			shape1.y += vel1.y * time;
			shape1.rotation += rot1 * time;
			shape2.x += vel2.x * time;
			shape2.y += vel2.y * time;
			shape2.rotation += rot2 * time;
		}
	}
}
