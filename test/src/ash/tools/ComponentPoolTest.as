package ash.tools
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.not;
	import org.hamcrest.object.sameInstance;

	public class ComponentPoolTest
	{
		[Before]
		public function createPool():void
		{
		}
		
		[After]
		public function destroyPool():void
		{
			ComponentPool.empty();
		}
		
		[Test]
		public function getRetrievesObjectOfAppropriateClass():void
		{
			assertThat(ComponentPool.get(MockComponent), isA(MockComponent));
		}
		
		[Test]
		public function disposedComponentsAreRetrievedByGet():void
		{
			var mockComponent:MockComponent = new MockComponent();
			ComponentPool.dispose(mockComponent);
			var retrievedComponent:MockComponent = ComponentPool.get(MockComponent);
			assertThat(retrievedComponent, sameInstance(mockComponent));
		}
		
		[Test]
		public function emptyPreventsRetrievalOfPreviouslyDisposedComponents():void
		{
			var mockComponent:MockComponent = new MockComponent();
			ComponentPool.dispose(mockComponent);
			ComponentPool.empty();
			var retrievedComponent:MockComponent = ComponentPool.get(MockComponent);
			assertThat(retrievedComponent, not(sameInstance(mockComponent)));
		}
	}
}

class MockComponent 
{
	public var value:uint;
}