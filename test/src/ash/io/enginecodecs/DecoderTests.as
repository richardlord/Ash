package ash.io.enginecodecs
{
	import ash.core.Engine;
	import ash.core.Entity;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.collection.hasItem;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isNotNull;
	import org.hamcrest.object.sameInstance;

	public class DecoderTests
	{
		private var endec : ObjectEngineCodec;
		private var original : Engine;
		private var engine : Engine;
		private var firstPoint : Point;
		private var secondPoint : Point;
		private var rectangle : Rectangle;

		[Before]
		public function createDecoder() : void
		{
			endec = new ObjectEngineCodec();
			original = new Engine();
			firstPoint = new Point( 1, 2 );
			secondPoint = new Point( 3, 4 );
			rectangle = new Rectangle( 5, 6, 7, 8 );
			var entity : Entity = new Entity();
			entity.name = "first";
			entity.add( firstPoint );
			original.addEntity( entity );
			entity = new Entity();
			entity.name = "second";
			entity.add( firstPoint );
			entity.add( rectangle );
			original.addEntity( entity );
			entity = new Entity();
			entity.add( secondPoint );
			original.addEntity( entity );
			var encodedData : Object = endec.encodeEngine( original );
			
			engine = new Engine();
			endec.decodeEngine( encodedData, engine );
		}

		[After]
		public function deleteEncoder() : void
		{
			endec = null;
			original = null;
			engine = null;
			firstPoint = null;
			secondPoint = null;
			rectangle = null;
		}
		
		[Test]
		public function decodedHasCorrectNumberOfEntities() : void
		{
			assertThat( engine.entities, arrayWithSize( 3 ) );
		}
		
		[Test]
		public function decodedHasCorrectEntityNames() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var names : Array = [];
			for each( var entity : Entity in entities )
			{
				names.push( entity.name );
			}
			assertThat( names, hasItems( "first", "second" ) );
		}

		[Test]
		public function decodedHasCorrectNullEntityNames() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var names : Array = [];
			for each( var entity : Entity in entities )
			{
				names.push( entity.name );
			}
			assertThat( names, hasItem( null ) );
		}
		
		[Test]
		public function firstEntityHasCorrectComponents() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var first : Entity;
			for each( var entity : Entity in entities )
			{
				if( entity.name == "first" )
				{
					first = entity;
					break;
				}
			}
			assertThat( first.getAll(), arrayWithSize( 1 ) );
			var point : Point = first.get( Point );
			assertThat( point, isNotNull() );
		}
		
		[Test]
		public function secondEntityHasCorrectComponents() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var second : Entity;
			for each( var entity : Entity in entities )
			{
				if( entity.name == "second" )
				{
					second = entity;
					break;
				}
			}
			assertThat( second.getAll(), arrayWithSize( 2 ) );
			var point : Point = second.get( Point );
			assertThat( point, isNotNull() );
			var rect : Rectangle = second.get( Rectangle );
			assertThat( rect, isNotNull() );
		}
		
		[Test]
		public function thirdEntityHasCorrectComponents() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var third : Entity;
			for each( var entity : Entity in entities )
			{
				if( entity.name == null )
				{
					third = entity;
					break;
				}
			}
			assertThat( third.getAll(), arrayWithSize( 1 ) );
			var point : Point = third.get( Point );
			assertThat( point, isNotNull() );
		}
		
		[Test]
		public function entitiesCorrectlyShareComponents() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var first : Entity;
			var second : Entity;
			for each( var entity : Entity in entities )
			{
				if( entity.name == "first" )
				{
					first = entity;
				}
				else if( entity.name == "second" )
				{
					second = entity;
				}
			}
			assertThat( first.get( Point ), sameInstance( second.get( Point ) ) );
		}

		[Test]
		public function firstEntityComponentsHaveCorrectValues() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var first : Entity;
			for each( var entity : Entity in entities )
			{
				if( entity.name == "first" )
				{
					first = entity;
					break;
				}
			}
			var point : Point = first.get( Point );
			assertThat( point.x, equalTo( firstPoint.x ) );
			assertThat( point.y, equalTo( firstPoint.y ) );
		}
		
		[Test]
		public function secondEntityComponentsHaveCorrectValues() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var second : Entity;
			for each( var entity : Entity in entities )
			{
				if( entity.name == "second" )
				{
					second = entity;
					break;
				}
			}
			var point : Point = second.get( Point );
			assertThat( point.x, equalTo( firstPoint.x ) );
			assertThat( point.y, equalTo( firstPoint.y ) );
			var rect : Rectangle = second.get( Rectangle );
			assertThat( rect.x, equalTo( rectangle.x ) );
			assertThat( rect.y, equalTo( rectangle.y ) );
			assertThat( rect.width, equalTo( rectangle.width ) );
			assertThat( rect.height, equalTo( rectangle.height ) );
		}
		
		[Test]
		public function thirdEntityComponentsHaveCorrectValues() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var third : Entity;
			for each( var entity : Entity in entities )
			{
				if( entity.name == null )
				{
					third = entity;
					break;
				}
			}
			var point : Point = third.get( Point );
			assertThat( point.x, equalTo( secondPoint.x ) );
			assertThat( point.y, equalTo( secondPoint.y ) );
		}
	}
}
