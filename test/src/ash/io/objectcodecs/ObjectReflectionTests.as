package ash.io.objectcodecs
{
	import ash.io.MockReflectionObject;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.sameInstance;
	
	public class ObjectReflectionTests
	{
		private var object : MockReflectionObject;
		private var reflection : ObjectReflection;
		
		[Before]
		public function createReflection() : void
		{
			object = new MockReflectionObject();
			reflection = new ObjectReflection( object );
		}
		
		[After]
		public function clearReflection() : void
		{
			object = null;
			reflection = null;
		}
		
		[Test]
		public function reflectionReturnsCorrectType() : void
		{
			assertThat( reflection.type, equalTo( "ash.io::MockReflectionObject" ) );
		}
		
		[Test]
		public function reflectionReturnsIntVariable() : void
		{
			assertThat( reflection.propertyTypes["intVariable"], equalTo( "int" ) );
		}
		
		[Test]
		public function reflectionReturnsUintVariable() : void
		{
			assertThat( reflection.propertyTypes["uintVariable"], equalTo( "uint" ) );
		}
		
		[Test]
		public function reflectionReturnsNumberVariable() : void
		{
			assertThat( reflection.propertyTypes["numberVariable"], equalTo( "Number" ) );
		}
		
		[Test]
		public function reflectionReturnsBooleanVariable() : void
		{
			assertThat( reflection.propertyTypes["booleanVariable"], equalTo( "Boolean" ) );
		}
		
		[Test]
		public function reflectionReturnsStringVariable() : void
		{
			assertThat( reflection.propertyTypes["stringVariable"], equalTo( "String" ) );
		}
		
		[Test]
		public function reflectionReturnsObjectVariable() : void
		{
			assertThat( reflection.propertyTypes["pointVariable"], equalTo( "flash.geom::Point" ) );
		}
		
		[Test]
		public function reflectionDoesntReturnNamespaceVariable() : void
		{
			assertThat( reflection.propertyTypes.hasOwnProperty( "namespaceVariable" ), isFalse() );
		}
		
		[Test]
		public function reflectionReturnsFullAccessor() : void
		{
			assertThat( reflection.propertyTypes["fullAccessor"], equalTo( "int" ) );
		}
		
		[Test]
		public function reflectionDoesntReturnGetOnlyAccessor() : void
		{
			assertThat( reflection.propertyTypes.hasOwnProperty( "getOnlyAccessor" ), isFalse() );
		}
		
		[Test]
		public function reflectionDoesntReturnSetOnlyAccessor() : void
		{
			assertThat( reflection.propertyTypes.hasOwnProperty( "setOnlyAccessor" ), isFalse() );
		}
		
		[Test]
		public function factoryCachesReflection() : void
		{
			var object1 : MockReflectionObject = new MockReflectionObject();
			var reflection1 : ObjectReflection = ObjectReflectionFactory.reflection( object1 );
			var object2 : MockReflectionObject = new MockReflectionObject();
			var reflection2 : ObjectReflection = ObjectReflectionFactory.reflection( object2 );
			assertThat( reflection2, sameInstance( reflection1 ) );
		}
	}
}