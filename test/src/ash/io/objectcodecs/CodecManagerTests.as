package ash.io.objectcodecs
{
	import org.hamcrest.assertThat;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.isNull;
	import org.hamcrest.object.sameInstance;

	import flash.geom.Point;

	public class CodecManagerTests
	{
		private var codecManager : CodecManager;
		
		[Before]
		public function createStore() : void
		{
			codecManager = new CodecManager();
		}
		
		[After]
		public function deleteStore() : void
		{
			codecManager = null;
		}
		
		[Test]
		public function codecForObjectReturnsNullByDefault() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForObject( new Point() );
			assertThat( codec, isNull() );
		}
		
		[Test]
		public function codecForComponentReturnsReflectionCodecByDefault() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForComponent( new Point() );
			assertThat( codec, instanceOf( ReflectionObjectCodec ) );
		}
		
		[Test]
		public function customCodecReturnedForComponentIfSet() : void
		{
			var setCodec : MockCodec = new MockCodec();
			codecManager.addCustomCodec( setCodec, Point );
			var returnedCodec : IObjectCodec = codecManager.getCodecForComponent( new Point() );
			assertThat( setCodec, sameInstance( returnedCodec ) );
		}
		
		[Test]
		public function customCodecReturnedForObjectIfSet() : void
		{
			var setCodec : MockCodec = new MockCodec();
			codecManager.addCustomCodec( setCodec, Point );
			var returnedCodec : IObjectCodec = codecManager.getCodecForObject( new Point() );
			assertThat( setCodec, sameInstance( returnedCodec ) );
		}
		
		[Test]
		public function codecForObjectReturnsNativeCodecForInt() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForObject( int( 5 ) );
			assertThat( codec, instanceOf( NativeObjectCodec ) );
		}
		
		[Test]
		public function codecForComponentReturnsNativeCodecForInt() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForComponent( int( 5 ) );
			assertThat( codec, instanceOf( NativeObjectCodec ) );
		}
		
		[Test]
		public function codecForObjectReturnsNativeCodecForUint() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForObject( uint( 5 ) );
			assertThat( codec, instanceOf( NativeObjectCodec ) );
		}
		
		[Test]
		public function codecForComponentReturnsNativeCodecForUint() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForComponent( uint( 5 ) );
			assertThat( codec, instanceOf( NativeObjectCodec ) );
		}
		
		[Test]
		public function codecForObjectReturnsNativeCodecForNumber() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForObject( 2.7 );
			assertThat( codec, instanceOf( NativeObjectCodec ) );
		}
		
		[Test]
		public function codecForComponentReturnsNativeCodecForNumber() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForComponent( 2.7 );
			assertThat( codec, instanceOf( NativeObjectCodec ) );
		}
		
		[Test]
		public function codecForObjectReturnsNativeCodecForString() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForObject( "Test" );
			assertThat( codec, instanceOf( NativeObjectCodec ) );
		}
		
		[Test]
		public function codecForComponentReturnsNativeCodecForString() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForComponent( "Test" );
			assertThat( codec, instanceOf( NativeObjectCodec ) );
		}
		
		[Test]
		public function codecForObjectReturnsNativeCodecForBoolean() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForObject( true );
			assertThat( codec, instanceOf( NativeObjectCodec ) );
		}
		
		[Test]
		public function codecForComponentReturnsNativeCodecForBoolean() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForComponent( true );
			assertThat( codec, instanceOf( NativeObjectCodec ) );
		}
		
		[Test]
		public function codecForObjectReturnsClassCodecForClass() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForObject( Point );
			assertThat( codec, instanceOf( ClassObjectCodec ) );
		}
		
		[Test]
		public function codecForComponentReturnsClassCodecForClass() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForComponent( Point );
			assertThat( codec, instanceOf( ClassObjectCodec ) );
		}
		
		[Test]
		public function codecForObjectReturnsArrayCodecForArray() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForObject( new Array() );
			assertThat( codec, instanceOf( ArrayObjectCodec ) );
		}
		
		[Test]
		public function codecForComponentReturnsArrayCodecForArray() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForComponent( new Array() );
			assertThat( codec, instanceOf( ArrayObjectCodec ) );
		}
		
		[Test]
		public function codecForObjectReturnsArrayCodecForVector() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForObject( new Vector.<int>() );
			assertThat( codec, instanceOf( ArrayObjectCodec ) );
		}
		
		[Test]
		public function codecForComponentReturnsArrayCodecForVector() : void
		{
			var codec : IObjectCodec = codecManager.getCodecForComponent( new Vector.<int>() );
			assertThat( codec, instanceOf( ArrayObjectCodec ) );
		}
	}
}

import ash.io.objectcodecs.CodecManager;
import ash.io.objectcodecs.IObjectCodec;

class MockCodec implements IObjectCodec
{
	public function encode( object : Object, codecManager : CodecManager ) : Object
	{
		return null;
	}
	public function decode( object : Object, codecManager : CodecManager ) : Object
	{
		return null;
	}
	public function decodeIntoObject( target : Object, object : Object, codecManager : CodecManager ) : void
	{

	}
	public function decodeIntoProperty( parent : Object, property : String, object : Object, codecManager : CodecManager ) : void
	{

	}
}
