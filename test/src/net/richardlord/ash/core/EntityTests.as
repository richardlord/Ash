package net.richardlord.ash.core
{
	import asunit.framework.IAsync;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.nullValue;
	import org.hamcrest.object.sameInstance;
	
	public class EntityTests
	{
		[Inject]
		public var async : IAsync;
		
		private var entity : Entity;
		
		[Before]
		public function createEntity() : void
		{
			entity = new Entity();
		}
		
		[After]
		public function clearEntity() : void
		{
			entity = null;
		}
		
		[Test]
		public function canStoreAndRetrieveComponent() : void
		{
			var component : MockComponent = new MockComponent();
			entity.add( component );
			assertThat( entity.get( MockComponent ), sameInstance( component ) );
		}
		
		[Test]
		public function canStoreAndRetrieveMultipleComponents() : void
		{
			var component1 : MockComponent = new MockComponent();
			entity.add( component1 );
			var component2 : MockComponent2 = new MockComponent2();
			entity.add( component2 );
			assertThat( entity.get( MockComponent ), sameInstance( component1 ) );
			assertThat( entity.get( MockComponent2 ), sameInstance( component2 ) );
		}
		
		[Test]
		public function canReplaceComponent() : void
		{
			var component1 : MockComponent = new MockComponent();
			entity.add( component1 );
			var component2 : MockComponent = new MockComponent();
			entity.add( component2 );
			assertThat( entity.get( MockComponent ), sameInstance( component2 ) );
		}
		
		[Test]
		public function canStoreBaseAndExtendedComponents() : void
		{
			var component1 : MockComponent = new MockComponent();
			entity.add( component1 );
			var component2 : MockComponentExtended = new MockComponentExtended();
			entity.add( component2 );
			assertThat( entity.get( MockComponent ), sameInstance( component1 ) );
			assertThat( entity.get( MockComponentExtended ), sameInstance( component2 ) );
		}
		
		[Test]
		public function canStoreExtendedComponentAsBaseType() : void
		{
			var component : MockComponentExtended = new MockComponentExtended();
			entity.add( component, MockComponent );
			assertThat( entity.get( MockComponent ), sameInstance( component ) );
		}
		
		[Test]
		public function getReturnNullIfNoComponent() : void
		{
			assertThat( entity.get( MockComponent ), nullValue() );
		}
		
		[Test]
		public function hasComponentIsFalseIfComponentTypeNotPresent() : void
		{
			entity.add( new MockComponent2() );
			assertThat( entity.has( MockComponent ), isFalse() );
		}
		
		[Test]
		public function hasComponentIsTrueIfComponentTypeIsPresent() : void
		{
			entity.add( new MockComponent() );
			assertThat( entity.has( MockComponent ), isTrue() );
		}
		
		[Test]
		public function canRemoveComponent() : void
		{
			var component : MockComponent = new MockComponent();
			entity.add( component );
			entity.remove( MockComponent );
			assertThat( entity.has( MockComponent ), isFalse() );
		}
		
		[Test]
		public function storingComponentTriggersAddedSignal() : void
		{
			var component : MockComponent = new MockComponent();
			entity.componentAdded.add( async.add() );
			entity.add( component );
		}
		
		[Test]
		public function removingComponentTriggersRemovedSignal() : void
		{
			var component : MockComponent = new MockComponent();
			entity.add( component );
			entity.componentRemoved.add( async.add() );
			entity.remove( MockComponent );
		}
		
		[Test]
		public function componentAddedSignalContainsCorrectParameters() : void
		{
			var component : MockComponent = new MockComponent();
			entity.componentAdded.add( async.add( testSignalContent, 10 ) );
			entity.add( component );
		}
		
		[Test]
		public function componentRemovedSignalContainsCorrectParameters() : void
		{
			var component : MockComponent = new MockComponent();
			entity.add( component );
			entity.componentRemoved.add( async.add( testSignalContent, 10 ) );
			entity.remove( MockComponent );
		}
		
		private function testSignalContent( signalEntity : Entity, componentClass : Class ) : void
		{
			assertThat( signalEntity, sameInstance( entity ) );
			assertThat( componentClass, sameInstance( MockComponent ) );
		}
	}
}

class MockComponent
{
	public var value : int;
}

class MockComponent2
{
	public var value : String;
}

class MockComponentExtended extends MockComponent
{
	public var other : int;
}