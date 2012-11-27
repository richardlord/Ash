package ash.io.objectcodecs
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;

	import flash.geom.Point;
	
	public class ClassObjectCodecTests
	{
		private var codec : ClassObjectCodec;
		private var codecManager : CodecManager;
		
		[Before]
		public function createCodec() : void
		{
			codecManager = new CodecManager();
			codec = new ClassObjectCodec();
		}
		
		[After]
		public function deleteCodec() : void
		{
			codec = null;
		}
		
		[Test]
		public function encodesClassWithCorrectType() : void
		{
			var input : Class = Point;
			var encoded : Object = codec.encode( input, codecManager );
			assertThat( encoded.type, equalTo( "Class" ) );
		}
		
		[Test]
		public function encodesClassWithCorrectValue() : void
		{
			var input : Class = Point;
			var encoded : Object = codec.encode( input, codecManager );
			assertThat( encoded.value, equalTo( "flash.geom::Point" ) );
		}
		
		[Test]
		public function decodesClassWithCorrectType() : void
		{
			var input : Class = Point;
			var encoded : Object = codec.encode( input, codecManager );
			var decoded : Object = codec.decode( encoded, codecManager );
			assertThat( decoded, instanceOf( Class ) );
		}
		
		[Test]
		public function decodesClassWithCorrectValue() : void
		{
			var input : Class = Point;
			var encoded : Object = codec.encode( input, codecManager );
			var decoded : Object = codec.decode( encoded, codecManager );
			assertThat( decoded, equalTo( Point ) );
		}
	}
}
