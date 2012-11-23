package ash.io.enginecodecs
{
	import ash.core.Engine;
	import ash.io.objectcodecs.IObjectCodec;

	public interface IEngineCodec
	{
		function addReflectableTypes( ...types ) : void;

		function addCustomCodec( codec : IObjectCodec, ...types ) : void;

		function encodeEngine( engine : Engine ) : Object;

		function decodeEngine( encodedData : Object, engine : Engine ) : void;
	}
}
