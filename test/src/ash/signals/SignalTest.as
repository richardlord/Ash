package ash.signals
{
	import asunit.asserts.fail;
	import asunit.framework.IAsync;
	import org.hamcrest.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.nullValue;

	public class SignalTest
	{
		[Inject]
		public var async : IAsync;
		
		protected var signal : Signal0;

		[Before]
		public function createSignal() : void
		{
			signal = new Signal0();
		}

		[After]
		public function destroySignal() : void
		{
			signal = null;
		}

		[Test]
		public function newSignalHasNullHead():void
		{
			assertThat( signal.head, nullValue() );
		}	

		[Test]
		public function newSignalHasListenersCountZero():void
		{
			assertThat( signal.numListeners, equalTo( 0 ) );
		}	
		
		[Test]
		public function addListenerThenDispatchShouldCallIt() : void
		{
			signal.add( async.add( newEmptyHandler(), 10 ) );
			dispatchSignal();
		}

		[Test]
		public function addListenerThenListenersCountIsOne():void
		{
			signal.add( newEmptyHandler() );
			assertThat( signal.numListeners, equalTo( 1 ) );
		}	
		
		[Test]
		public function addListenerThenRemoveThenDispatchShouldNotCallListener() : void
		{
			signal.add( failIfCalled );
			signal.remove( failIfCalled );
			dispatchSignal();
		}

		[Test]
		public function addListenerThenRemoveThenListenersCountIsZero():void
		{
			signal.add( failIfCalled );
			signal.remove( failIfCalled );
			assertThat( signal.numListeners, equalTo( 0 ) );
		}	

		[Test]
		public function removeFunctionNotInListenersShouldNotThrowError() : void
		{
			signal.remove( newEmptyHandler() );
			dispatchSignal();
		}

		[Test]
		public function addListenerThenRemoveFunctionNotInListenersShouldStillCallListener() : void
		{
			signal.add( async.add( newEmptyHandler(), 10 ) );
			signal.remove( newEmptyHandler() );
			dispatchSignal();
		}

		[Test]
		public function add2ListenersThenDispatchShouldCallBoth() : void
		{
			signal.add( async.add( newEmptyHandler(), 10 ) );
			signal.add( async.add( newEmptyHandler(), 10 ) );
			dispatchSignal();
		}

		[Test]
		public function add2ListenersThenListenersCountIsTwo():void
		{
			signal.add( newEmptyHandler() );
			signal.add( newEmptyHandler() );
			assertThat( signal.numListeners, equalTo( 2 ) );
		}	

		[Test]
		public function add2ListenersRemove1stThenDispatchShouldCall2ndNot1stListener() : void
		{
			signal.add( failIfCalled );
			signal.add( async.add( newEmptyHandler(), 10 ) );
			signal.remove( failIfCalled );
			dispatchSignal();
		}

		[Test]
		public function add2ListenersRemove2ndThenDispatchShouldCall1stNot2ndListener() : void
		{
			signal.add( async.add( newEmptyHandler(), 10 ) );
			signal.add( failIfCalled );
			signal.remove( failIfCalled );
			dispatchSignal();
		}
		
		[Test]
		public function add2ListenersThenRemove1ThenListenersCountIsOne():void
		{
			signal.add( newEmptyHandler() );
			signal.add( failIfCalled );
			signal.remove( failIfCalled );
			assertThat( signal.numListeners, equalTo( 1 ) );
		}	

		[Test]
		public function addSameListenerTwiceShouldOnlyAddItOnce() : void
		{
			var count : int = 0;
			var func : Function = function( ...args ) : void { ++count; };
			signal.add( func );
			signal.add( func );
			dispatchSignal();
			assertThat( count, equalTo( 1 ) );
		}

		[Test]
		public function addTheSameListenerTwiceShouldNotThrowError() : void
		{
			var listener : Function = newEmptyHandler();
			signal.add( listener );
			signal.add( listener );
		}
		
		[Test]
		public function addSameListenerTwiceThenListenersCountIsOne():void
		{
			signal.add( failIfCalled );
			signal.add( failIfCalled );
			assertThat( signal.numListeners, equalTo( 1 ) );
		}	

		[Test]
		public function dispatch2Listeners1stListenerRemovesItselfThen2ndListenerIsStillCalled() : void
		{
			signal.add( selfRemover );
			signal.add( async.add( newEmptyHandler(), 10 ) );
			dispatchSignal();
		}

		[Test]
		public function dispatch2Listeners2ndListenerRemovesItselfThen1stListenerIsStillCalled() : void
		{
			signal.add( async.add( newEmptyHandler(), 10 ) );
			signal.add( selfRemover );
			dispatchSignal();
		}

		private function selfRemover( ...args ) : void
		{
			signal.remove( selfRemover );
		}

		[Test]
		public function addingAListenerDuringDispatchShouldNotCallIt() : void
		{
			signal.add( async.add( addListenerDuringDispatch, 10 ) );
			dispatchSignal();
		}

		private function addListenerDuringDispatch() : void
		{
			signal.add( failIfCalled );
		}

		[Test]
		public function addingAListenerDuringDispatchIncrementsListenersCount() : void
		{
			signal.add( addListenerDuringDispatchToTestCount );
			dispatchSignal();
			assertThat( signal.numListeners, equalTo( 2 ) );
		}

		private function addListenerDuringDispatchToTestCount() : void
		{
			assertThat( signal.numListeners, equalTo( 1 ) );
			signal.add( newEmptyHandler() );
			assertThat( signal.numListeners, equalTo( 2 ) );
		}

		[Test]
		public function dispatch2Listeners2ndListenerRemoves1stThen1stListenerIsNotCalled() : void
		{
			signal.add( async.add( removeFailListener, 10 ) );
			signal.add( failIfCalled );
			dispatchSignal();
		}

		private function removeFailListener( ...args ) : void
		{
			signal.remove( failIfCalled );
		}
		
		[Test]
		public function add2ListenersThenRemoveAllShouldLeaveNoListeners():void
		{
			signal.add( newEmptyHandler() );
			signal.add( newEmptyHandler() );
			signal.removeAll();
			assertThat( signal.head, nullValue() );
		}
		
		[Test]
		public function addListenerThenRemoveAllThenAddAgainShouldAddListener():void
		{
			var handler : Function = newEmptyHandler();
			signal.add( handler );
			signal.removeAll();
			signal.add( handler );
			assertThat( signal.numListeners, equalTo( 1 ) );
		}
		
		[Test]
		public function add2ListenersThenRemoveAllThenListenerCountIsZero():void
		{
			signal.add( newEmptyHandler() );
			signal.add( newEmptyHandler() );
			signal.removeAll();
			assertThat( signal.numListeners, equalTo( 0 ) );
		}
		
		[Test]
		public function removeAllDuringDispatchShouldStopAll():void
		{
			signal.add( removeAllListeners );
			signal.add( failIfCalled );
			signal.add( newEmptyHandler() );
			dispatchSignal();
		}

		private function removeAllListeners( ...args ) : void
		{
			signal.removeAll();
		}

		[Test]
		public function addOnceListenerThenDispatchShouldCallIt() : void
		{
			signal.addOnce( async.add( newEmptyHandler(), 10 ) );
			dispatchSignal();
		}

		[Test]
		public function addOnceListenerShouldBeRemovedAfterDispatch() : void
		{
			signal.addOnce( newEmptyHandler() );
			dispatchSignal();
			assertThat( signal.head, nullValue() );
		}

		// //// UTILITY METHODS // ////

		private function dispatchSignal() : void
		{
			signal.dispatch();
		}

		private static function newEmptyHandler() : Function
		{
			return function( ...args ) : void
			{
			};
		}

		private static function failIfCalled( ...args ) : void
		{
			fail( 'This function should not have been called.' );
		}
	}
}