package net.richardlord.asteroids.graphics
{
	import starling.textures.Texture;
	import starling.display.Image;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;

	public class AsteroidView extends Image
	{
		public function AsteroidView( radius : Number )
		{
			var angle : Number = 0;
			var shape : Shape = new Shape();
			shape.graphics.beginFill( 0xFFFFFF );
			shape.graphics.moveTo( radius, 0 );
			while( angle < Math.PI * 2 )
			{
				var length : Number = ( 0.75 + Math.random() * 0.25 ) * radius;
				var posX : Number = Math.cos( angle ) * length;
				var posY : Number = Math.sin( angle ) * length;
				shape.graphics.lineTo( posX, posY );
				angle += Math.random() * 0.5;
			}
			shape.graphics.lineTo( radius, 0 );
			shape.graphics.endFill();
			
			var bitmapData : BitmapData = new BitmapData( radius * 2, radius * 2, true, 0 );
			var transform : Matrix = new Matrix();
			transform.tx = transform.ty = radius;
			bitmapData.draw( shape, transform, null, null, null, true );
			
			var texture : Texture = Texture.fromBitmapData( bitmapData, false, false, 1 );
			super( texture );
			pivotX = radius;
			pivotY = radius;
		}
	}
}
