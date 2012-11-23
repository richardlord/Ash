package ash.io.objectcodecs
{
	public interface IObjectCodec
	{
		function encode( object : Object ) : Object;
		function decode( object : Object ) : Object;
	}
}
