package net.richardlord.ash.core
{
	import asunit.framework.IAsync;

	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
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
		}

		[Test]
		public function addSystemCallsAddToGame() : void
		{
			var system : System = new MockSystem( this );
			asyncCallback = async.add( addedCallbackMethod, 10 );
			game.addSystem( system );
		}

		[Test]
		public function removeSystemCallsRemovedFromGame() : void
		{
			var system : System = new MockSystem( this );
			game.addSystem( system );
			asyncCallback = async.add( removedCallbackMethod, 10 );
			game.removeSystem( system );
		}

		[Test]
		public function gameCallsUpdateOnSystems() : void
		{
			var system : System = new MockSystem( this );
			game.addSystem( system );
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
			game.addSystemWithPriority( system, 10 );
			assertThat( system.priority, equalTo( 10 ) );
		}
		
		[Test]
		public function systemsUpdatedInPriorityOrderIfSameAsAddOrder() : void
		{
			system1 = new MockSystem( this );
			game.addSystemWithPriority( system1, 10 );
			system2 = new MockSystem( this );
			game.addSystemWithPriority( system2, 20 );
			asyncCallback = async.add( updateCallbackMethod1, 10 );
			game.update( 0.1 );
		}
		
		[Test]
		public function systemsUpdatedInPriorityOrderIfReverseOfAddOrder() : void
		{
			system2 = new MockSystem( this );
			game.addSystemWithPriority( system2, 20 );
			system1 = new MockSystem( this );
			game.addSystemWithPriority( system1, 10 );
			asyncCallback = async.add( updateCallbackMethod1, 10 );
			game.update( 0.1 );
		}

		[Test]
		public function systemsUpdatedInPriorityOrderIfPrioritiesAreNegative() : void
		{
			system2 = new MockSystem( this );
			game.addSystemWithPriority( system2, 10 );
			system1 = new MockSystem( this );
			game.addSystemWithPriority( system1, -20 );
			asyncCallback = async.add( updateCallbackMethod1, 10 );
			game.update( 0.1 );
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