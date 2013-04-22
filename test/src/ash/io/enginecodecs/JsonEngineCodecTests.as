package ash.io.enginecodecs
{
	import ash.core.Engine;
	import ash.core.Entity;
	import ash.io.MockComponent1;
	import ash.io.MockComponent2;

	import org.hamcrest.assertThat;
	import org.hamcrest.collection.arrayWithSize;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.instanceOf;
	import org.hamcrest.object.isNotNull;
	import org.hamcrest.object.sameInstance;

	public class JsonEngineCodecTests
	{
		private var endec : JsonEngineCodec;
		private var original : Engine;
		private var engine : Engine;
		private var firstComponent1 : MockComponent1;
		private var secondComponent1 : MockComponent1;
		private var onlyComponent2 : MockComponent2;
		private var encodedData : Object;

		[Before]
		public function createDecoder() : void
		{
			endec = new JsonEngineCodec();
			original = new Engine();
			firstComponent1 = new MockComponent1( 1, 2 );
			secondComponent1 = new MockComponent1( 3, 4 );
			onlyComponent2 = new MockComponent2( 5, 6 );
			var entity : Entity = new Entity();
			entity.name = "first";
			entity.add( firstComponent1 );
			original.addEntity( entity );
			entity = new Entity();
			entity.name = "second";
			entity.add( firstComponent1 );
			entity.add( onlyComponent2 );
			original.addEntity( entity );
			entity = new Entity();
			entity.name = "third";
			entity.add( secondComponent1 );
			original.addEntity( entity );
			encodedData = endec.encodeEngine( original );
			engine = new Engine();
			endec.decodeEngine( encodedData, engine );
		}

		[After]
		public function deleteEncoder() : void
		{
			endec = null;
			original = null;
			engine = null;
			firstComponent1 = null;
			secondComponent1 = null;
			onlyComponent2 = null;
		}
		
		[Test]
		public function encodedDataIsAString() : void
		{
			assertThat( encodedData, instanceOf( String ) );
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
			assertThat( names, hasItems( "first", "second", "third" ) );
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
			var component : MockComponent1 = first.get( MockComponent1 );
			assertThat( component, isNotNull() );
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
			var component1 : MockComponent1 = second.get( MockComponent1 );
			assertThat( component1, isNotNull() );
			var component2 : MockComponent2 = second.get( MockComponent2 );
			assertThat( component2, isNotNull() );
		}
		
		[Test]
		public function thirdEntityHasCorrectComponents() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var third : Entity;
			for each( var entity : Entity in entities )
			{
				if( entity.name == "third" )
				{
					third = entity;
					break;
				}
			}
			assertThat( third.getAll(), arrayWithSize( 1 ) );
			var component : MockComponent1 = third.get( MockComponent1 );
			assertThat( component, isNotNull() );
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
			assertThat( first.get( MockComponent1 ), sameInstance( second.get( MockComponent1 ) ) );
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
			var component : MockComponent1 = first.get( MockComponent1 );
			assertThat( component.x, equalTo( firstComponent1.x ) );
			assertThat( component.y, equalTo( firstComponent1.y ) );
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
			var component1 : MockComponent1 = second.get( MockComponent1 );
			assertThat( component1.x, equalTo( firstComponent1.x ) );
			assertThat( component1.y, equalTo( firstComponent1.y ) );
			var component2 : MockComponent2 = second.get( MockComponent2 );
			assertThat( component2.x, equalTo( onlyComponent2.x ) );
			assertThat( component2.y, equalTo( onlyComponent2.y ) );
		}
		
		[Test]
		public function thirdEntityComponentsHaveCorrectValues() : void
		{
			var entities : Vector.<Entity> = engine.entities;
			var third : Entity;
			for each( var entity : Entity in entities )
			{
				if( entity.name == "third" )
				{
					third = entity;
					break;
				}
			}
			var component1 : MockComponent1 = third.get( MockComponent1 );
			assertThat( component1.x, equalTo( secondComponent1.x ) );
			assertThat( component1.y, equalTo( secondComponent1.y ) );
		}
	}
}