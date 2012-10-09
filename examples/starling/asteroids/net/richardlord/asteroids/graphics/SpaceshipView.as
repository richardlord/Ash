package net.richardlord.asteroids.graphics
{
	import starling.display.Image;
	import starling.textures.Texture;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	
	public class SpaceshipView extends Image
	{
		public function SpaceshipView()
		{
			var shape : Shape = new Shape();
			shape.graphics.beginFill( 0xFFFFFF );
			shape.graphics.moveTo( 10, 0 );
			shape.graphics.lineTo( -7, 7 );
			shape.graphics.lineTo( -4, 0 );
			shape.graphics.lineTo( -7, -7 );
			shape.graphics.lineTo( 10, 0 );
			shape.graphics.endFill();

			var bitmapData : BitmapData = new BitmapData( 17, 14, true, 0 );
			var transform : Matrix = new Matrix();
			transform.tx = 7;
			transform.ty = 7;
			bitmapData.draw( shape, transform, null, null, null, true );
			
			var texture : Texture = Texture.fromBitmapData( bitmapData, false, false, 1 );
			super( texture );
			pivotX = 7;
			pivotY = 7;
		}
	}
}
