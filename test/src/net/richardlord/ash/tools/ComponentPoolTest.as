package net.richardlord.ash.tools
{
	import org.hamcrest.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.core.not;
	import org.hamcrest.object.sameInstance;

	public class ComponentPoolTest
	{
		private var componentPool:ComponentPool;
		
		[Before]
		public function createPool():void
		{
			componentPool = new ComponentPool();
		}
		
		[After]
		public function destroyPool():void
		{
			componentPool.empty();
			componentPool = null;
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
			componentPool.empty();
			var retrievedComponent:MockComponent = ComponentPool.get(MockComponent);
			assertThat(retrievedComponent, not(sameInstance(mockComponent)));
		}
	}
}

class MockComponent 
{
	public var value:uint;
}