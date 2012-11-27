package ash.io.objectcodecs
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ClassObjectCodec implements IObjectCodec
	{
		public function encode( object : Object, codecManager : CodecManager ) : Object
		{
			return { type: "Class", value : getQualifiedClassName( object ) };
		}

		public function decode( object : Object, codecManager : CodecManager ) : Object
		{
			return getDefinitionByName( object.value );
		}
	}
}
