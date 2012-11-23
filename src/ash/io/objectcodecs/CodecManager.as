package ash.io.objectcodecs
{
	import flash.utils.Dictionary;

	public class CodecManager
	{
		private var codecs : Dictionary;
		private var reflectionCodec : ReflectionObjectCodec;

		public function CodecManager()
		{
			codecs = new Dictionary();
			reflectionCodec = new ReflectionObjectCodec( this );
		}

		public function getCodecForObject( object : Object ) : IObjectCodec
		{
			if ( !( object is Class ) )
			{
				object = object.constructor;
			}
			if ( codecs[object] )
			{
				return codecs[object];
			}
			return null;
		}

		public function getCodecForComponent( component : Object ) : IObjectCodec
		{
			if ( !( component is Class ) )
			{
				component = component.constructor;
			}
			if ( codecs[component] )
			{
				return codecs[component];
			}
			return reflectionCodec;
		}

		public function addReflectableType( type : Class ) : void
		{
			codecs[type] = reflectionCodec;
		}

		public function addCustomCodec( codec : IObjectCodec, type : Class ) : void
		{
			codecs[type] = codec;
		}
	}
}
