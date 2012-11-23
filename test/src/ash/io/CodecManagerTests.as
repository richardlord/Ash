package ash.io
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
			assertThat( codec, instanceOf( ReflectionCodec ) );
		}
		
		[Test]
		public function reflectionCodecReturnedIfSet() : void
		{
			codecManager.addReflectableType( Point );
			var codec : IObjectCodec = codecManager.getCodecForObject( new Point() );
			assertThat( codec, instanceOf( ReflectionCodec ) );
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
	}
}

import ash.io.IObjectCodec;

class MockCodec implements IObjectCodec
{
	public function encode( object : Object ) : Object
	{
		return null;
	}
	public function decode( object : Object ) : Object
	{
		return null;
	}
}
