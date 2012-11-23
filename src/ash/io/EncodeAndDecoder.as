package ash.io
{
	import ash.core.Engine;

	public class EncodeAndDecoder
	{
		private var encoder : Encoder;
		private var decoder : Decoder;
		private var codecManager : CodecManager;

		public function EncodeAndDecoder()
		{
			codecManager = new CodecManager();
			encoder = new Encoder( codecManager );
			decoder = new Decoder( codecManager );
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

		public function reset() : void
		{
			encoder.reset();
			decoder.reset();
		}

		public function encodeEngine( engine : Engine ) : Object
		{
			return encoder.encodeEngine( engine );
		}

		public function decodeEngine( encodedData : Object, engine : Engine ) : void
		{
			decoder.decodeEngine( encodedData, engine );
		}
	}
}
