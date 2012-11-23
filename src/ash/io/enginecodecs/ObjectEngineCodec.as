package ash.io.enginecodecs
{
	import ash.core.Engine;
	import ash.io.objectcodecs.CodecManager;
	import ash.io.objectcodecs.IObjectCodec;

	public class ObjectEngineCodec implements IEngineCodec
	{
		private var encoder : ObjectEncoder;
		private var decoder : ObjectDecoder;
		private var codecManager : CodecManager;

		public function ObjectEngineCodec()
		{
			codecManager = new CodecManager();
			encoder = new ObjectEncoder( codecManager );
			decoder = new ObjectDecoder( codecManager );
		}

		public function addReflectableTypes( ...types ) : void
		{
			for each ( var type : Class in types )
			{
				codecManager.addReflectableType( type );
			}
		}

		public function addCustomCodec( codec : IObjectCodec, ...types ) : void
		{
			for each ( var type : Class in types )
			{
				codecManager.addCustomCodec( codec, type );
			}
		}

		public function encodeEngine( engine : Engine ) : Object
		{
			encoder.reset();
			return encoder.encodeEngine( engine );
		}

		public function decodeEngine( encodedData : Object, engine : Engine ) : void
		{
			decoder.reset();
			decoder.decodeEngine( encodedData, engine );
		}
	}
}
