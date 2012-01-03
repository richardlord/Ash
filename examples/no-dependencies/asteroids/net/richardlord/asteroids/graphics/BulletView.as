package net.richardlord.asteroids.graphics
{
	import flash.display.Shape;

	public class BulletView extends Shape
	{
		public function BulletView()
		{
			graphics.beginFill( 0xFFFFFF );
			graphics.drawCircle( 0, 0, 2 );
			graphics.endFill();
		}
	}
}
