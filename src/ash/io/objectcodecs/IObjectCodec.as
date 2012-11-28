package ash.io.objectcodecs
{
	public interface IObjectCodec
	{
		function encode( object : Object, codecManager : CodecManager ) : Object;
		function decode( object : Object, codecManager : CodecManager ) : Object;
		function decodeInto( target : Object, object : Object, codecManager : CodecManager ) : void;
	}
}
