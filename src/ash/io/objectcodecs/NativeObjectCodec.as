package ash.io.objectcodecs
{
	import flash.utils.getQualifiedClassName;
	import ash.io.objectcodecs.IObjectCodec;
	import ash.io.objectcodecs.CodecManager;

	public class NativeObjectCodec implements IObjectCodec
	{
		public function encode( object : Object, codecManager : CodecManager ) : Object
		{
			return { type: getQualifiedClassName( object ), value : object };
		}

		public function decode( object : Object, codecManager : CodecManager ) : Object
		{
			return object.value;
		}
	}
}
