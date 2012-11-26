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
}
