package ash.io.objectcodecs
{
	import flash.utils.getDefinitionByName;

	public class ReflectionObjectCodec implements IObjectCodec
	{
		private var codecManager : CodecManager;

		public function ReflectionObjectCodec( codecManager : CodecManager )
		{
			this.codecManager = codecManager;
		}

		public function encode( object : Object ) : Object
		{
			var reflection : ObjectReflection = ObjectReflectionFactory.reflection( object );
			var properties : Object = {};
			var codec : IObjectCodec;
			for ( var name : String in reflection.propertyTypes )
			{
				var type : String = reflection.propertyTypes[name];
				if ( isNativeType( type ) )
				{
					properties[ name ] = { type : type, value : object[ name ] };
				}
				else if ( object[ name ] === null )
				{
					codec = codecManager.getCodecForObject( getDefinitionByName( type ) );
					if ( codec )
					{
						properties[ name ] = { type : type, value : null };
					}
				}
				else
				{
					codec = codecManager.getCodecForObject( object[ name ] );
					if ( codec )
					{
						properties[ name ] = codec.encode( object[ name ] );
					}
				}
			}
			return { type:reflection.type, properties:properties };
		}

		public function decode( object : Object ) : Object
		{
			var type : Class = getDefinitionByName( object.type ) as Class;
			var decoded : Object = new type();
			for ( var name : String in object.properties )
			{
				var encoded : Object = object.properties[name];
				if ( isNativeType( encoded.type ) )
				{
					decoded[name] = encoded.value;
				}
				else if( encoded.hasOwnProperty("value") && encoded.value == null )
				{
					decoded[name] = null;
				}
				else
				{
					var codec : IObjectCodec = codecManager.getCodecForObject( getDefinitionByName( encoded.type ) );
					if ( codec )
					{
						decoded[ name ] = codec.decode( encoded );
					}
				}
			}
			return decoded;
		}

		private function isNativeType( type : String ) : Boolean
		{
			return type == "int" || type == "uint" || type == "Number" || type == "String" || type == "Boolean";
		}
	}
}
