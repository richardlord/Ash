package ash.io.enginecodecs
{
	import ash.core.Engine;
	import ash.core.Entity;

	import asunit.framework.IAsync;

	import org.hamcrest.assertThat;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.hasProperty;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class EncoderTests
	{
		[Inject]
		public var async : IAsync;

		private var endec : ObjectEngineCodec;
		private var engine : Engine;
		private var firstPoint : Point;
		private var secondPoint : Point;
		private var rectangle : Rectangle;
		private var encodedData : Object;

		[Before]
		public function createEncoder() : void
		{
			endec = new ObjectEngineCodec();
			engine = new Engine();
			firstPoint = new Point( 1, 2 );
			secondPoint = new Point( 3, 4 );
			rectangle = new Rectangle( 5, 6, 7, 8 );
			var entity : Entity = new Entity();
			entity.name = "first";
			entity.add( firstPoint );
			engine.addEntity( entity );
			entity = new Entity();
			entity.name = "second";
			entity.add( firstPoint );
			entity.add( rectangle );
			engine.addEntity( entity );
			entity = new Entity();
			entity.name = "third";
			entity.add( secondPoint );
			engine.addEntity( entity );
			encodedData = endec.encodeEngine( engine );
		}

		[After]
		public function deleteEncoder() : void
		{
			endec = null;
			engine = null;
			firstPoint = null;
			secondPoint = null;
			rectangle = null;
		}

		[Test]
		public function encodedDataHasEntitiesProperty() : void
		{
			assertThat( encodedData, hasProperty( "entities" ) );
		}

		[Test]
		public function encodedDataHasCorrectNumberOfEntities() : void
		{
			assertThat( encodedData.entities, arrayWithSize( 3 ) );
		}

		[Test]
		public function entityNamesAreCorrectlyEncoded() : void
		{
			var names : Array = [
				encodedData.entities[0].name,
				encodedData.entities[1].name,
				encodedData.entities[2].name
			];
			assertThat( names, hasItems( "first", "second" ) );
		}

		[Test]
		public function entitiesCorrectlyShareComponents() : void
		{
			var first : Object;
			var second : Object;
			var third : Object;
			for each( var entity : Object in encodedData.entities )
			{
				if( entity.name == "first" )
				{
					first = entity;
				}
				else if( entity.name == "second" )
				{
					second = entity;
				}
				else
				{
					third = entity;
				}
			}
			assertThat( second.components, hasItem( first.components[0] ) );
		}

		[Test]
		public function entitiesHaveCorrectNumberOfComponents() : void
		{
			var first : Object;
			var second : Object;
			var third : Object;
			for each( var entity : Object in encodedData.entities )
			{
				if( entity.name == "first" )
				{
					first = entity;
				}
				else if( entity.name == "second" )
				{
					second = entity;
				}
				else
				{
					third = entity;
				}
			}
			assertThat( first.components, arrayWithSize( 1 ) );
			assertThat( second.components, arrayWithSize( 2 ) );
			assertThat( third.components, arrayWithSize( 1 ) );
		}

		[Test]
		public function encodedDataHasComponentsProperty() : void
		{
			assertThat( encodedData, hasProperty( "components" ) );
		}

		[Test]
		public function encodedDataHasAllComponents() : void
		{
			assertThat( encodedData.components, arrayWithSize( 3 ) );
		}
		
		[Test]
		public function firstEntityHasCorrectComponents() : void
		{
			var first : Object;
			for each( var entity : Object in encodedData.entities )
			{
				if( entity.name == "first" )
				{
					first = entity;
					break;
				}
			}
			var pointId : int = first.components[0];
			var pointEncoded : Object;
			for each( var component : Object in encodedData.components )
			{
				if( component.id == pointId )
				{
					pointEncoded = component;
					break;
				}
			}
			assertThat( pointEncoded.type, equalTo( "flash.geom::Point" ) );
			assertThat( pointEncoded.properties.x.value, equalTo( firstPoint.x ) );
			assertThat( pointEncoded.properties.y.value, equalTo( firstPoint.y ) );
		}
		
		[Test]
		public function secondEntityHasCorrectComponents() : void
		{
			var second : Object;
			for each( var entity : Object in encodedData.entities )
			{
				if( entity.name == "second" )
				{
					second = entity;
					break;
				}
			}
			var pointEncoded : Object;
			var rectangleEncoded : Object;
			for each( var id : int in second.components )
			{
				for each( var component : Object in encodedData.components )
				{
					if( component.id == id )
					{
						if( component.type == "flash.geom::Point" )
						{
							pointEncoded = component;
						}
						else
						{
							rectangleEncoded = component;
						}
					}
				}
			}
			
			assertThat( pointEncoded.type, equalTo( "flash.geom::Point" ) );
			assertThat( pointEncoded.properties.x.value, equalTo( firstPoint.x ) );
			assertThat( pointEncoded.properties.y.value, equalTo( firstPoint.y ) );
			
			assertThat( rectangleEncoded.type, equalTo( "flash.geom::Rectangle" ) );
			assertThat( rectangleEncoded.properties.x.value, equalTo( rectangle.x ) );
			assertThat( rectangleEncoded.properties.y.value, equalTo( rectangle.y ) );
			assertThat( rectangleEncoded.properties.width.value, equalTo( rectangle.width ) );
			assertThat( rectangleEncoded.properties.height.value, equalTo( rectangle.height ) );
		}
		
		[Test]
		public function thirdEntityHasCorrectComponents() : void
		{
			var third : Object;
			for each( var entity : Object in encodedData.entities )
			{
				if( entity.name == "third" )
				{
					third = entity;
					break;
				}
			}
			var pointId : int = third.components[0];
			var pointEncoded : Object;
			for each( var component : Object in encodedData.components )
			{
				if( component.id == pointId )
				{
					pointEncoded = component;
					break;
				}
			}
			assertThat( pointEncoded.type, equalTo( "flash.geom::Point" ) );
			assertThat( pointEncoded.properties.x.value, equalTo( secondPoint.x ) );
			assertThat( pointEncoded.properties.y.value, equalTo( secondPoint.y ) );
		}
		
		[Test]
		public function encodingTriggersCompleteSignal() : void
		{
			endec.encodeComplete.add( async.add() );
			encodedData = endec.encodeEngine( engine );
		}
	}
}
