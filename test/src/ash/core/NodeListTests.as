package ash.core
{
	import ash.matchers.nodeList;
	import asunit.framework.IAsync;
	import org.hamcrest.assertThat;
	import org.hamcrest.collection.emptyArray;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.sameInstance;


	
	public class NodeListTests
	{
		[Inject]
		public var async : IAsync;
		
		private var nodes : NodeList;
		
		[Before]
		public function createEntity() : void
		{
			nodes = new NodeList();
		}

		[After]
		public function clearEntity() : void
		{
			nodes = null;
		}

		[Test]
		public function addingNodeTriggersAddedSignal() : void
		{
			var node : MockNode = new MockNode();
			nodes.nodeAdded.add( async.add() );
			nodes.add( node );
		}
		
		[Test]
		public function removingNodeTriggersRemovedSignal() : void
		{
			var node : MockNode = new MockNode();
			nodes.add( node );
			nodes.nodeRemoved.add( async.add() );
			nodes.remove( node );
		}
		
		[Test]
		public function AllNodesAreCoveredDuringIteration() : void
		{
			var nodeArray : Array = new Array();
			for( var i : int = 0; i < 5; ++i )
			{
				var node : MockNode = new MockNode();
				nodeArray.push( node );
				nodes.add( node );
			}
			
			for( node = nodes.head; node; node = node.next )
			{
				var index : int = nodeArray.indexOf( node );
				nodeArray.splice( index, 1 );
			}
			assertThat( nodeArray, emptyArray() );
		}
		
		[Test]
		public function removingCurrentNodeDuringIterationIsValid() : void
		{
			var nodeArray : Array = new Array();
			for( var i : int = 0; i < 5; ++i )
			{
				var node : MockNode = new MockNode();
				nodeArray.push( node );
				nodes.add( node );
			}
			
			var count : int;
			for( node = nodes.head; node; node = node.next )
			{
				var index : int = nodeArray.indexOf( node );
				nodeArray.splice( index, 1 );
				if( ++count == 2 )
				{
					nodes.remove( node );
				}
			}
			assertThat( nodeArray, emptyArray() );
		}
		
		[Test]
		public function removingNextNodeDuringIterationIsValid() : void
		{
			var nodeArray : Array = new Array();
			for( var i : int = 0; i < 5; ++i )
			{
				var node : MockNode = new MockNode();
				nodeArray.push( node );
				nodes.add( node );
			}
			
			var count : int;
			for( node = nodes.head; node; node = node.next )
			{
				var index : int = nodeArray.indexOf( node );
				nodeArray.splice( index, 1 );
				if( ++count == 2 )
				{
					nodes.remove( node.next );
				}
			}
			assertThat( nodeArray.length, equalTo( 1 ) );
		}
		
		private var tempNode : Node;
		
		[Test]
		public function componentAddedSignalContainsCorrectParameters() : void
		{
			tempNode = new MockNode();
			nodes.nodeAdded.add( async.add( testSignalContent, 10 ) );
			nodes.add( tempNode );
		}
		
		[Test]
		public function componentRemovedSignalContainsCorrectParameters() : void
		{
			tempNode = new MockNode();
			nodes.add( tempNode );
			nodes.nodeRemoved.add( async.add( testSignalContent, 10 ) );
			nodes.remove( tempNode );
		}
		
		private function testSignalContent( signalNode : Node ) : void
		{
			assertThat( signalNode, sameInstance( tempNode ) );
		}
		
		[Test]
		public function nodesInitiallySortedInOrderOfAddition() : void
		{
			var node1 : MockNode = new MockNode();
			var node2 : MockNode = new MockNode();
			var node3 : MockNode = new MockNode();
			nodes.add( node1 );
			nodes.add( node2 );
			nodes.add( node3 );
			assertThat( nodes, nodeList( node1, node2, node3 ) );
		}
		
		[Test]
		public function swappingOnlyTwoNodesChangesTheirOrder() : void
		{
			var node1 : MockNode = new MockNode();
			var node2 : MockNode = new MockNode();
			nodes.add( node1 );
			nodes.add( node2 );
			nodes.swap( node1, node2 );
			assertThat( nodes, nodeList( node2, node1 ) );
		}
		
		[Test]
		public function swappingAdjacentNodesChangesTheirPositions() : void
		{
			var node1 : MockNode = new MockNode();
			var node2 : MockNode = new MockNode();
			var node3 : MockNode = new MockNode();
			var node4 : MockNode = new MockNode();
			nodes.add( node1 );
			nodes.add( node2 );
			nodes.add( node3 );
			nodes.add( node4 );
			nodes.swap( node2, node3 );
			assertThat( nodes, nodeList( node1, node3, node2, node4 ) );
		}
		
		[Test]
		public function swappingNonAdjacentNodesChangesTheirPositions() : void
		{
			var node1 : MockNode = new MockNode();
			var node2 : MockNode = new MockNode();
			var node3 : MockNode = new MockNode();
			var node4 : MockNode = new MockNode();
			var node5 : MockNode = new MockNode();
			nodes.add( node1 );
			nodes.add( node2 );
			nodes.add( node3 );
			nodes.add( node4 );
			nodes.add( node5 );
			nodes.swap( node2, node4 );
			assertThat( nodes, nodeList( node1, node4, node3, node2, node5 ) );
		}
		
		[Test]
		public function swappingEndNodesChangesTheirPositions() : void
		{
			var node1 : MockNode = new MockNode();
			var node2 : MockNode = new MockNode();
			var node3 : MockNode = new MockNode();
			nodes.add( node1 );
			nodes.add( node2 );
			nodes.add( node3 );
			nodes.swap( node1, node3 );
			assertThat( nodes, nodeList( node3, node2, node1 ) );
		}
		
		[Test]
		public function insertionSortCorrectlySortsSortedNodes() : void
		{
			var node1 : MockNode = new MockNode( 1 );
			var node2 : MockNode = new MockNode( 2 );
			var node3 : MockNode = new MockNode( 3 );
			var node4 : MockNode = new MockNode( 4 );
			nodes.add( node1 );
			nodes.add( node2 );
			nodes.add( node3 );
			nodes.add( node4 );
			nodes.insertionSort( sortFunction );
			assertThat( nodes, nodeList( node1, node2, node3, node4 ) );
		}
		
		[Test]
		public function insertionSortCorrectlySortsReversedNodes() : void
		{
			var node1 : MockNode = new MockNode( 1 );
			var node2 : MockNode = new MockNode( 2 );
			var node3 : MockNode = new MockNode( 3 );
			var node4 : MockNode = new MockNode( 4 );
			nodes.add( node4 );
			nodes.add( node3 );
			nodes.add( node2 );
			nodes.add( node1 );
			nodes.insertionSort( sortFunction );
			assertThat( nodes, nodeList( node1, node2, node3, node4 ) );
		}
		
		[Test]
		public function insertionSortCorrectlySortsMixedNodes() : void
		{
			var node1 : MockNode = new MockNode( 1 );
			var node2 : MockNode = new MockNode( 2 );
			var node3 : MockNode = new MockNode( 3 );
			var node4 : MockNode = new MockNode( 4 );
			var node5 : MockNode = new MockNode( 5 );
			nodes.add( node3 );
			nodes.add( node4 );
			nodes.add( node1 );
			nodes.add( node5 );
			nodes.add( node2 );
			nodes.insertionSort( sortFunction );
			assertThat( nodes, nodeList( node1, node2, node3, node4, node5 ) );
		}
		
		[Test]
		public function insertionSortRetainsTheOrderOfEquivalentNodes() : void
		{
			var node1 : MockNode = new MockNode( 1 );
			var node2 : MockNode = new MockNode( 1 );
			var node3 : MockNode = new MockNode( 3 );
			var node4 : MockNode = new MockNode( 4 );
			var node5 : MockNode = new MockNode( 4 );
			nodes.add( node3 );
			nodes.add( node4 );
			nodes.add( node1 );
			nodes.add( node5 );
			nodes.add( node2 );
			nodes.insertionSort( sortFunction );
			assertThat( nodes, nodeList( node1, node2, node3, node4, node5 ) );
		}
		
		[Test]
		public function mergeSortCorrectlySortsSortedNodes() : void
		{
			var node1 : MockNode = new MockNode( 1 );
			var node2 : MockNode = new MockNode( 2 );
			var node3 : MockNode = new MockNode( 3 );
			var node4 : MockNode = new MockNode( 4 );
			nodes.add( node1 );
			nodes.add( node2 );
			nodes.add( node3 );
			nodes.add( node4 );
			nodes.mergeSort( sortFunction );
			assertThat( nodes, nodeList( node1, node2, node3, node4 ) );
		}
		
		[Test]
		public function mergeSortCorrectlySortsReversedNodes() : void
		{
			var node1 : MockNode = new MockNode( 1 );
			var node2 : MockNode = new MockNode( 2 );
			var node3 : MockNode = new MockNode( 3 );
			var node4 : MockNode = new MockNode( 4 );
			nodes.add( node4 );
			nodes.add( node3 );
			nodes.add( node2 );
			nodes.add( node1 );
			nodes.mergeSort( sortFunction );
			assertThat( nodes, nodeList( node1, node2, node3, node4 ) );
		}
		
		[Test]
		public function mergeSortCorrectlySortsMixedNodes() : void
		{
			var node1 : MockNode = new MockNode( 1 );
			var node2 : MockNode = new MockNode( 2 );
			var node3 : MockNode = new MockNode( 3 );
			var node4 : MockNode = new MockNode( 4 );
			var node5 : MockNode = new MockNode( 5 );
			nodes.add( node3 );
			nodes.add( node4 );
			nodes.add( node1 );
			nodes.add( node5 );
			nodes.add( node2 );
			nodes.mergeSort( sortFunction );
			assertThat( nodes, nodeList( node1, node2, node3, node4, node5 ) );
		}
		
		private function sortFunction( node1 : MockNode, node2 : MockNode ) : Number
		{
			return node1.pos - node2.pos;
		}
	}
}

import ash.core.Node;
import flash.geom.Matrix;
import flash.geom.Point;

class MockNode extends Node
{
	public var pos : int;
	
	public function MockNode( value : int = 0 )
	{
		pos = value;
	}
}
