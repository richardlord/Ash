package net.richardlord.asteroids.graphics
{
	import starling.display.Image;
	import starling.textures.Texture;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;

	public class BulletView extends Image
	{
		public function BulletView()
		{
			var shape : Shape = new Shape();
			shape.graphics.beginFill( 0xFFFFFF );
			shape.graphics.drawCircle( 0, 0, 2 );
			shape.graphics.endFill();

			var bitmapData : BitmapData = new BitmapData( 4, 4, true, 0 );
			var transform : Matrix = new Matrix();
			transform.tx = 2;
			transform.ty = 2;
			bitmapData.draw( shape, transform, null, null, null, true );
			
			var texture : Texture = Texture.fromBitmapData( bitmapData, false, false, 1 );
			super( texture );
			pivotX = 2;
			pivotY = 2;
		}
	}
}
