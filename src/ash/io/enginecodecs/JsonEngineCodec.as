package ash.io.enginecodecs
{
	import ash.core.Engine;
	import ash.io.objectcodecs.IObjectCodec;

	public class JsonEngineCodec implements IEngineCodec
	{
		private var objectEngineCodec : ObjectEngineCodec;

		public function JsonEngineCodec()
		{
			objectEngineCodec = new ObjectEngineCodec();
		}

		public function addReflectableTypes( ...types ) : void
		{
			objectEngineCodec.addReflectableTypes.apply( objectEngineCodec, types );
		}

		public function addCustomCodec( codec : IObjectCodec, ...types ) : void
		{
			types.unshift( codec );
			objectEngineCodec.addCustomCodec.apply( objectEngineCodec, types );
		}

		public function encodeEngine( engine : Engine ) : Object
		{
			var object : Object = objectEngineCodec.encodeEngine( engine );
			var encoded : String = JSON.stringify( object );
			return encoded;
		}

		public function decodeEngine( encodedData : Object, engine : Engine ) : void
		{
			var object : Object = JSON.parse( encodedData as String );
			objectEngineCodec.decodeEngine( object, engine );
		}
	}
}
