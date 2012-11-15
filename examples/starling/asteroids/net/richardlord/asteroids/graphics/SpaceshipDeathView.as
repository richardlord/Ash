package net.richardlord.asteroids.graphics
{
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;
	
	public class SpaceshipDeathView extends Sprite implements Animatable
	{
		private var image1 : Image;
		private var image2 : Image;
		private var vel1 : Point;
		private var vel2 : Point;
		private var rot1 : Number;
		private var rot2 : Number;
		
		public function SpaceshipDeathView()
		{
			createImage1();
			createImage2();
			
			vel1 = new Point( Math.random() * 10 - 5, Math.random() * 10 + 10 );
			vel2 = new Point( Math.random() * 10 - 5, - ( Math.random() * 10 + 10 ) );
			
			rot1 = Math.random() * 6 - 3;
			rot2 = Math.random() * 6 - 3;
		}
		
		private function createImage1() : void
		{
			var shape : Shape = new Shape();
			shape.graphics.beginFill( 0xFFFFFF );
			shape.graphics.moveTo( 10, 0 );
			shape.graphics.lineTo( -7, 7 );
			shape.graphics.lineTo( -4, 0 );
			shape.graphics.lineTo( 10, 0 );
			shape.graphics.endFill();
			
			var bitmapData : BitmapData = new BitmapData( 17, 7, true, 0 );
			var transform : Matrix = new Matrix();
			transform.tx = 7;
			transform.ty = 0;
			bitmapData.draw( shape, transform, null, null, null, true );
			
			var texture : Texture = Texture.fromBitmapData( bitmapData, false, false, 1 );
			image1 = new Image( texture );
			image1.pivotX = 7;
			image1.pivotY = 0;
			
			addChild( image1 );
		}
		
		private function createImage2() : void
		{
			var shape : Shape = new Shape();
			shape.graphics.beginFill( 0xFFFFFF );
			shape.graphics.moveTo( 10, 0 );
			shape.graphics.lineTo( -7, -7 );
			shape.graphics.lineTo( -4, 0 );
			shape.graphics.lineTo( 10, 0 );
			shape.graphics.endFill();
			
			var bitmapData : BitmapData = new BitmapData( 17, 7, true, 0 );
			var transform : Matrix = new Matrix();
			transform.tx = 7;
			transform.ty = 7;
			bitmapData.draw( shape, transform, null, null, null, true );
			
			var texture : Texture = Texture.fromBitmapData( bitmapData, false, false, 1 );
			image2 = new Image( texture );
			image2.pivotX = 7;
			image2.pivotY = 7;
			
			addChild( image2 );
		}
		
		public function animate( time : Number ) : void
		{
			image1.x += vel1.x * time;
			image1.y += vel1.y * time;
			image1.rotation += rot1 * time;
			image2.x += vel2.x * time;
			image2.y += vel2.y * time;
			image2.rotation += rot2 * time;
		}
	}
}
