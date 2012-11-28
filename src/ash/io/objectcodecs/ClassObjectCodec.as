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

		public function decodeInto( target : Object, object : Object, codecManager : CodecManager ) : void
		{
			target = getDefinitionByName( object.value ); // this won't work because native objects (i.e. target) are not passed by reference
		}
	}
}
