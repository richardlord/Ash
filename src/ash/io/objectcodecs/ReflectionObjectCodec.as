package ash.io.objectcodecs
{
	import flash.utils.getDefinitionByName;

	public class ReflectionObjectCodec implements IObjectCodec
	{
		public function encode( object : Object, codecManager : CodecManager ) : Object
		{
			var reflection : ObjectReflection = ObjectReflectionFactory.reflection( object );
			var properties : Object = {};
			for ( var name : String in reflection.propertyTypes )
			{
				properties[ name ] = codecManager.encodeObject( object[name] );
			}
			return { type:reflection.type, properties:properties };
		}

		public function decode( object : Object, codecManager : CodecManager ) : Object
		{
			var type : Class = getDefinitionByName( object.type ) as Class;
			var decoded : Object = new type();
			for ( var name : String in object.properties )
			{
				decoded[name] = codecManager.decodeObject( object.properties[name] );
			}
			return decoded;
		}
	}
}
