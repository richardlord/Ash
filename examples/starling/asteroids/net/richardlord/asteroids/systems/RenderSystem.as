package net.richardlord.asteroids.systems
{
	import net.richardlord.ash.core.Game;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.components.Display;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.RenderNode;

	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	
	public class RenderSystem extends System
	{
		public var container : DisplayObjectContainer;
		
		private var nodes : NodeList;
		
		public function RenderSystem( container : DisplayObjectContainer )
		{
			this.container = container;
		}
		
		override public function addToGame( game : Game ) : void
		{
			nodes = game.getNodeList( RenderNode );
			for( var node : RenderNode = nodes.head; node; node = node.next )
			{
				addToDisplay( node );
			}
			nodes.nodeAdded.add( addToDisplay );
			nodes.nodeRemoved.add( removeFromDisplay );
		}
		
		private function addToDisplay( node : RenderNode ) : void
		{
			container.addChild( node.display.displayObject );
		}
		
		private function removeFromDisplay( node : RenderNode ) : void
		{
			container.removeChild( node.display.displayObject );
		}
		
		override public function update( time : Number ) : void
		{
			var node : RenderNode;
			var position : Position;
			var display : Display;
			var displayObject : DisplayObject;
			
			for( node = nodes.head; node; node = node.next )
			{
				display = node.display;
				displayObject = display.displayObject;
				position = node.position;
				
				displayObject.x = position.position.x;
				displayObject.y = position.position.y;
				displayObject.rotation = position.rotation;
			}
		}

		override public function removeFromGame( game : Game ) : void
		{
			nodes = null;
		}
	}
}
