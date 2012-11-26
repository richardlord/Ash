package ash.io.objectcodecs
{
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.array;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	
	public class ArrayObjectCodecTests
	{
		private var codec : ArrayObjectCodec;
		private var codecManager : CodecManager;
		
		[Before]
		public function createCodec() : void
		{
			codecManager = new CodecManager();
			codec = new ArrayObjectCodec();
		}
		
		[After]
		public function deleteCodec() : void
		{
			codec = null;
		}
		
		[Test]
		public function encodesArrayWithCorrectType() : void
		{
			var input : Array = [ 7, 6, 5, 4, 3 ];
			var encoded : Object = codec.encode( input, codecManager );
			assertThat( encoded.type, equalTo( "Array" ) );
		}
		
		[Test]
		public function encodesArrayWithCorrectProperties() : void
		{
			var input : Array = [ 7, 6, 5, 4, 3 ];
			var encoded : Object = codec.encode( input, codecManager );
			assertThat( encoded.values, arrayWithSize( 5 ) );
			assertThat( encoded.values[0].value, equalTo( 7 ) );
			assertThat( encoded.values[1].value, equalTo( 6 ) );
			assertThat( encoded.values[2].value, equalTo( 5 ) );
			assertThat( encoded.values[3].value, equalTo( 4 ) );
			assertThat( encoded.values[4].value, equalTo( 3 ) );
		}
		
		[Test]
		public function encodesVectorWithCorrectType() : void
		{
			var input : Vector.<int> = new <int>[ 7, 6, 5, 4, 3 ];
			var encoded : Object = codec.encode( input, codecManager );
			assertThat( encoded.type, equalTo( "__AS3__.vec::Vector.<int>" ) );
		}
		
		[Test]
		public function encodesVectorWithCorrectProperties() : void
		{
			var input : Vector.<int> = new <int>[ 7, 6, 5, 4, 3 ];
			var encoded : Object = codec.encode( input, codecManager );
			assertThat( encoded.values, arrayWithSize( 5 ) );
			assertThat( encoded.values[0].value, equalTo( 7 ) );
			assertThat( encoded.values[1].value, equalTo( 6 ) );
			assertThat( encoded.values[2].value, equalTo( 5 ) );
			assertThat( encoded.values[3].value, equalTo( 4 ) );
			assertThat( encoded.values[4].value, equalTo( 3 ) );
		}
		
		[Test]
		public function decodesArrayWithCorrectType() : void
		{
			var input : Array = [ 7, 6, 5, 4, 3 ];
			var encoded : Object = codec.encode( input, codecManager );
			var decoded : Object = codec.decode( encoded, codecManager );
			assertThat( decoded, instanceOf( Array ) );
		}
		
		[Test]
		public function decodesArrayWithCorrectProperties() : void
		{
			var input : Array = [ 7, 6, 5, 4, 3 ];
			var encoded : Object = codec.encode( input, codecManager );
			var decoded : Object = codec.decode( encoded, codecManager );
			assertThat( decoded, array( 7, 6, 5, 4, 3 ) );
		}
		
		[Test]
		public function decodesVectorWithCorrectType() : void
		{
			var input : Vector.<int> = new <int>[ 7, 6, 5, 4, 3 ];
			var encoded : Object = codec.encode( input, codecManager );
			var decoded : Object = codec.decode( encoded, codecManager );
			assertThat( decoded, instanceOf( Vector.<int> as Class ) );
		}
		
		[Test]
		public function decodesVectorWithCorrectProperties() : void
		{
			var input : Vector.<int> = new <int>[ 7, 6, 5, 4, 3 ];
			var encoded : Object = codec.encode( input, codecManager );
			var decoded : Object = codec.decode( encoded, codecManager );
			assertThat( decoded, array( 7, 6, 5, 4, 3 ) );
		}
	}
}
