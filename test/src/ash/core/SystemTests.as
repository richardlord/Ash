package ash.core
{
	import asunit.framework.IAsync;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.hasItems;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.isFalse;
	import org.hamcrest.object.isTrue;
	import org.hamcrest.object.nullValue;
	import org.hamcrest.object.sameInstance;


	public class SystemTests
	{
		[Inject]
		public var async : IAsync;
		
		public var asyncCallback : Function;
		
		private var engine : Engine;
		
		private var system1 : MockSystem;
		private var system2 : MockSystem;

		[Before]
		public function createEntity() : void
		{
			engine = new Engine();
		}

		[After]
		public function clearEntity() : void
		{
			engine = null;
			asyncCallback = null;
		}

		[Test]
		public function systemsGetterReturnsAllTheSystems() : void
		{
			var system1 : System = new System();
			engine.addSystem( system1, 1 );
			var system2 : System = new System();
			engine.addSystem( system2, 1 );
			assertThat( engine.systems.length, equalTo( 2 ) );
			assertThat( engine.systems, hasItems( system1, system2 ) );
		}

		[Test]
		public function addSystemCallsAddToEngine() : void
		{
			var system : System = new MockSystem( this );
			asyncCallback = async.add( addedCallbackMethod, 10 );
			engine.addSystem( system, 0 );
		}

		[Test]
		public function removeSystemCallsRemovedFromEngine() : void
		{
			var system : System = new MockSystem( this );
			engine.addSystem( system, 0 );
			asyncCallback = async.add( removedCallbackMethod, 10 );
			engine.removeSystem( system );
		}

		[Test]
		public function engineCallsUpdateOnSystems() : void
		{
			var system : System = new MockSystem( this );
			engine.addSystem( system, 0 );
			asyncCallback = async.add( updateCallbackMethod, 10 );
			engine.update( 0.1 );
		}
		
		[Test]
		public function defaultPriorityIsZero() : void
		{
			var system : System = new MockSystem( this );
			assertThat( system.priority, equalTo( 0 ) );
		}
		
		[Test]
		public function canSetPriorityWhenAddingSystem() : void
		{
			var system : System = new MockSystem( this );
			engine.addSystem( system, 10 );
			assertThat( system.priority, equalTo( 10 ) );
		}
		
		[Test]
		public function systemsUpdatedInPriorityOrderIfSameAsAddOrder() : void
		{
			system1 = new MockSystem( this );
			engine.addSystem( system1, 10 );
			system2 = new MockSystem( this );
			engine.addSystem( system2, 20 );
			asyncCallback = async.add( updateCallbackMethod1, 10 );
			engine.update( 0.1 );
		}
		
		[Test]
		public function systemsUpdatedInPriorityOrderIfReverseOfAddOrder() : void
		{
			system2 = new MockSystem( this );
			engine.addSystem( system2, 20 );
			system1 = new MockSystem( this );
			engine.addSystem( system1, 10 );
			asyncCallback = async.add( updateCallbackMethod1, 10 );
			engine.update( 0.1 );
		}

		[Test]
		public function systemsUpdatedInPriorityOrderIfPrioritiesAreNegative() : void
		{
			system2 = new MockSystem( this );
			engine.addSystem( system2, 10 );
			system1 = new MockSystem( this );
			engine.addSystem( system1, -20 );
			asyncCallback = async.add( updateCallbackMethod1, 10 );
			engine.update( 0.1 );
		}
		
		[Test]
		public function updatingIsFalseBeforeUpdate() : void
		{
			assertThat( engine.updating, isFalse() );
		}
		
		[Test]
		public function updatingIsTrueDuringUpdate() : void
		{
			var system : System = new MockSystem( this );
			engine.addSystem( system, 0 );
			asyncCallback = assertsUpdatingIsTrue;
			engine.update( 0.1 );
		}
		
		[Test]
		public function updatingIsFalseAfterUpdate() : void
		{
			engine.update( 0.1 );
			assertThat( engine.updating, isFalse() );
		}
		
		[Test]
		public function completeSignalIsDispatchedAfterUpdate() : void
		{
			var system : System = new MockSystem( this );
			engine.addSystem( system, 0 );
			asyncCallback = listensForUpdateComplete;
			engine.update( 0.1 );
		}
		
		[Test]
		public function getSystemReturnsTheSystem() : void
		{
			var system1 : System = new MockSystem( this );
			engine.addSystem( system1, 0 );
			engine.addSystem( new System(), 0 );
			assertThat( engine.getSystem( MockSystem ), sameInstance( system1 ) );
		}
		
		[Test]
		public function getSystemReturnsNullIfNoSuchSystem() : void
		{
			engine.addSystem( new System(), 0 );
			assertThat( engine.getSystem( MockSystem ), nullValue() );
		}
		
		[Test]
		public function removeAllSystemsDoesWhatItSays() : void
		{
			engine.addSystem( new System(), 0 );
			engine.addSystem( new MockSystem( this ), 0 );
			engine.removeAllSystems();
			assertThat( engine.getSystem( MockSystem ), nullValue() );
			assertThat( engine.getSystem( System ), nullValue() );
		}
		
		[Test]
		public function removeSystemAndAddItAgainDontCauseInvalidLinkedList() : void
		{
			var systemB : System = new System();
			var systemC : System = new System();
			engine.addSystem( systemB, 0 );
			engine.addSystem( systemC, 0 );
			engine.removeSystem( systemB );
			engine.addSystem( systemB, 0 );
			assertThat( systemC.previous, nullValue() );
			assertThat( systemB.next, nullValue() );
		}
     
	 	private function addedCallbackMethod( system : System, action : String, systemEngine : Engine ) : void
		{
			assertThat( action, equalTo( "added" ) );
			assertThat( systemEngine, sameInstance( engine ) );
		}

		private function removedCallbackMethod( system : System, action : String, systemEngine : Engine ) : void
		{
			assertThat( action, equalTo( "removed" ) );
			assertThat( systemEngine, sameInstance( engine ) );
		}

		private function updateCallbackMethod( system : System, action : String, time : Number ) : void
		{
			assertThat( action, equalTo( "update" ) );
			assertThat( time, equalTo( 0.1 ) );
		}

		private function updateCallbackMethod1( system : System, action : String, time : Number ) : void
		{
			assertThat( system, equalTo( system1 ) );
			asyncCallback = async.add( updateCallbackMethod2, 10 );
		}

		private function updateCallbackMethod2( system : System, action : String, time : Number ) : void
		{
			assertThat( system, equalTo( system2 ) );
		}

		private function assertsUpdatingIsTrue( system : System, action : String, time : Number ) : void
		{
			assertThat( engine.updating, isTrue() );
		}
		
		private function listensForUpdateComplete( system : System, action : String, time : Number ) : void
		{
			engine.updateComplete.add( async.add() );
		}
	}
}
import ash.core.Engine;
import ash.core.System;
import ash.core.SystemTests;

class MockSystem extends System
{
	private var tests : SystemTests;

	public function MockSystem( tests : SystemTests )
	{
		this.tests = tests;
	}

	override public function addToEngine( engine : Engine ) : void
	{
		if( tests.asyncCallback != null )
			tests.asyncCallback( this, "added", engine );
	}

	override public function removeFromEngine( engine : Engine ) : void
	{
		if( tests.asyncCallback != null )
			tests.asyncCallback( this, "removed", engine );
	}

	override public function update( time : Number ) : void
	{
		if( tests.asyncCallback != null )
			tests.asyncCallback( this, "update", time );
	}
}