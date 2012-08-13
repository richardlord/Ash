package net.richardlord.ash.core
{
	import asunit.framework.IAsync;

	import org.hamcrest.assertThat;
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
		
		private var game : Game;
		
		private var system1 : MockSystem;
		private var system2 : MockSystem;

		[Before]
		public function createEntity() : void
		{
			game = new Game();
		}

		[After]
		public function clearEntity() : void
		{
			game = null;
			asyncCallback = null;
		}

		[Test]
		public function addSystemCallsAddToGame() : void
		{
			var system : System = new MockSystem( this );
			asyncCallback = async.add( addedCallbackMethod, 10 );
			game.addSystem( system, 0 );
		}

		[Test]
		public function removeSystemCallsRemovedFromGame() : void
		{
			var system : System = new MockSystem( this );
			game.addSystem( system, 0 );
			asyncCallback = async.add( removedCallbackMethod, 10 );
			game.removeSystem( system );
		}

		[Test]
		public function gameCallsUpdateOnSystems() : void
		{
			var system : System = new MockSystem( this );
			game.addSystem( system, 0 );
			asyncCallback = async.add( updateCallbackMethod, 10 );
			game.update( 0.1 );
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
			game.addSystem( system, 10 );
			assertThat( system.priority, equalTo( 10 ) );
		}
		
		[Test]
		public function systemsUpdatedInPriorityOrderIfSameAsAddOrder() : void
		{
			system1 = new MockSystem( this );
			game.addSystem( system1, 10 );
			system2 = new MockSystem( this );
			game.addSystem( system2, 20 );
			asyncCallback = async.add( updateCallbackMethod1, 10 );
			game.update( 0.1 );
		}
		
		[Test]
		public function systemsUpdatedInPriorityOrderIfReverseOfAddOrder() : void
		{
			system2 = new MockSystem( this );
			game.addSystem( system2, 20 );
			system1 = new MockSystem( this );
			game.addSystem( system1, 10 );
			asyncCallback = async.add( updateCallbackMethod1, 10 );
			game.update( 0.1 );
		}

		[Test]
		public function systemsUpdatedInPriorityOrderIfPrioritiesAreNegative() : void
		{
			system2 = new MockSystem( this );
			game.addSystem( system2, 10 );
			system1 = new MockSystem( this );
			game.addSystem( system1, -20 );
			asyncCallback = async.add( updateCallbackMethod1, 10 );
			game.update( 0.1 );
		}
		
		[Test]
		public function updatingIsFalseBeforeUpdate() : void
		{
			assertThat( game.updating, isFalse() );
		}
		
		[Test]
		public function updatingIsTrueDuringUpdate() : void
		{
			var system : System = new MockSystem( this );
			game.addSystem( system, 0 );
			asyncCallback = assertsUpdatingIsTrue;
			game.update( 0.1 );
		}
		
		[Test]
		public function updatingIsFalseAfterUpdate() : void
		{
			game.update( 0.1 );
			assertThat( game.updating, isFalse() );
		}
		
		[Test]
		public function completeSignalIsDispatchedAfterUpdate() : void
		{
			var system : System = new MockSystem( this );
			game.addSystem( system, 0 );
			asyncCallback = listensForUpdateComplete;
			game.update( 0.1 );
		}
		
		[Test]
		public function getSystemReturnsTheSystem() : void
		{
			var system1 : System = new MockSystem( this );
			game.addSystem( system1, 0 );
			game.addSystem( new System(), 0 );
			assertThat( game.getSystem( MockSystem ), sameInstance( system1 ) );
		}
		
		[Test]
		public function getSystemReturnsNullIfNoSuchSystem() : void
		{
			game.addSystem( new System(), 0 );
			assertThat( game.getSystem( MockSystem ), nullValue() );
		}
		
		[Test]
		public function removeAllSystemsDoesWhatItSays() : void
		{
			game.addSystem( new System(), 0 );
			game.addSystem( new MockSystem( this ), 0 );
			game.removeAllSystems();
			assertThat( game.getSystem( MockSystem ), nullValue() );
			assertThat( game.getSystem( System ), nullValue() );
		}
		
		[Test]
		public function removeSystemAndAddItAgainDontCauseInvalidLinkedList() : void
		{
			var systemB : System = new System();
			var systemC : System = new System();
			game.addSystem( systemB, 0 );
			game.addSystem( systemC, 0 );
			game.removeSystem( systemB );
			game.addSystem( systemB, 0 );
			// game.update( 0.1 ); causes infinite loop in failing test
			assertThat( systemC.previous, nullValue() );
			assertThat( systemB.next, nullValue() );
		}
     
	 	private function addedCallbackMethod( system : System, action : String, systemGame : Game ) : void
		{
			assertThat( action, equalTo( "added" ) );
			assertThat( systemGame, sameInstance( game ) );
		}

		private function removedCallbackMethod( system : System, action : String, systemGame : Game ) : void
		{
			assertThat( action, equalTo( "removed" ) );
			assertThat( systemGame, sameInstance( game ) );
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
			assertThat( game.updating, isTrue() );
		}
		
		private function listensForUpdateComplete( system : System, action : String, time : Number ) : void
		{
			game.updateComplete.add( async.add() );
		}
	}
}
import net.richardlord.ash.core.Game;
import net.richardlord.ash.core.System;
import net.richardlord.ash.core.SystemTests;

class MockSystem extends System
{
	private var tests : SystemTests;

	public function MockSystem( tests : SystemTests )
	{
		this.tests = tests;
	}

	override public function addToGame( game : Game ) : void
	{
		if( tests.asyncCallback != null )
			tests.asyncCallback( this, "added", game );
	}

	override public function removeFromGame( game : Game ) : void
	{
		if( tests.asyncCallback != null )
			tests.asyncCallback( this, "removed", game );
	}

	override public function update( time : Number ) : void
	{
		if( tests.asyncCallback != null )
			tests.asyncCallback( this, "update", time );
	}
}