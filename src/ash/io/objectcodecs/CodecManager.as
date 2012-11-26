package ash.io.objectcodecs
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class CodecManager
	{
		private var codecs : Dictionary;
		private var reflectionCodec : ReflectionObjectCodec;
		private var arrayCodec : ArrayObjectCodec;

		public function CodecManager()
		{
			codecs = new Dictionary();
			reflectionCodec = new ReflectionObjectCodec();
			arrayCodec = new ArrayObjectCodec();
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
			var className : String = getQualifiedClassName( object );
			if( className == "Array" || className.substr( 0, 20 ) == "__AS3__.vec::Vector." )
			{
				return arrayCodec;
			}
			return null;
		}

		public function getCodecForComponent( component : Object ) : IObjectCodec
		{
			var codec : IObjectCodec = getCodecForObject( component );
			if ( codec == null )
			{
				return reflectionCodec;
			}
			return codec;
		}

		public function addCustomCodec( codec : IObjectCodec, type : Class ) : void
		{
			codecs[type] = codec;
		}

		public function encodeComponent( object : Object ) : Object
		{
			if ( object === null )
			{
				return { value : null };
			}
			var codec : IObjectCodec;
			var type : String = getQualifiedClassName( object );
			if ( isNativeType( type ) )
			{
				return { type : type, value : object };
			}
			else
			{
				codec = getCodecForComponent( object );
				if ( codec )
				{
					return codec.encode( object, this );
				}
				else
				{
					return { value : null };
				}
			}
			return { value : null };
		}

		public function encodeObject( object : Object ) : Object
		{
			if ( object === null )
			{
				return { value : null };
			}
			var codec : IObjectCodec;
			var type : String = getQualifiedClassName( object );
			if ( isNativeType( type ) )
			{
				return { type : type, value : object };
			}
			else
			{
				codec = getCodecForObject( object );
				if ( codec )
				{
					return codec.encode( object, this );
				}
			}
			return { value : null };
		}

		public function decodeComponent( object : Object ) : Object
		{
			if( !object.hasOwnProperty( "type" ) && object.hasOwnProperty( "value" ) && object.value === null )
			{
				return null;
			}
			if ( isNativeType( object.type ) )
			{
				return object.value;
			}
			else if( object.hasOwnProperty("value") && object.value == null )
			{
				return null;
			}
			else
			{
				var codec : IObjectCodec = getCodecForComponent( getDefinitionByName( object.type ) );
				if ( codec )
				{
					return codec.decode( object, this );
				}
			}
			return null;
		}

		public function decodeObject( object : Object ) : Object
		{
			if( !object.hasOwnProperty( "type" ) )
			{
				return null;
			}
			if ( isNativeType( object.type ) )
			{
				return object.value;
			}
			else if( object.hasOwnProperty("value") && object.value == null )
			{
				return null;
			}
			else
			{
				var codec : IObjectCodec = getCodecForObject( getDefinitionByName( object.type ) );
				if ( codec )
				{
					return codec.decode( object, this );
				}
			}
			return null;
		}

		private function isNativeType( type : String ) : Boolean
		{
			return type == "int" || type == "uint" || type == "Number" || type == "String" || type == "Boolean";
		}
	}
}
