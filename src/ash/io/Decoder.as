package ash.io
{
	import ash.core.Engine;
	import ash.core.Entity;

	import flash.utils.getDefinitionByName;

	public class Decoder
	{
		private var codecManager : CodecManager;
		private var componentMap : Array;

		public function Decoder( codecManager : CodecManager )
		{
			this.codecManager = codecManager;
			componentMap = new Array();
		}

		public function reset() : void
		{
		}

		public function decodeEngine( encodedData : Object, engine : Engine ) : void
		{
			for each ( var encodedComponent : Object in encodedData.components )
			{
				decodeComponent( encodedComponent );
			}

			for each ( var encodedEntity : Object in encodedData.entities )
			{
				engine.addEntity( decodeEntity( encodedEntity ) );
			}
		}

		private function decodeEntity( encodedEntity : Object ) : Entity
		{
			var entity : Entity = new Entity();
			if ( encodedEntity.hasOwnProperty( "name" ) )
			{
				entity.name = encodedEntity.name;
			}
			for each ( var componentId : int in encodedEntity.components )
			{
				if ( componentMap.hasOwnProperty( componentId ) )
				{
					entity.add( componentMap[componentId] );
				}
			}
			return entity;
		}

		private function decodeComponent( encodedComponent : Object ) : void
		{
			var codec : IObjectCodec = codecManager.getCodecForComponent( getDefinitionByName( encodedComponent.type ) );
			componentMap[encodedComponent.id] = codec.decode( encodedComponent );
		}
	}
}
