package net.richardlord.asteroids.systems
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import net.richardlord.ash.core.NodeList;
	import net.richardlord.ash.core.System;
	import net.richardlord.asteroids.components.Display;
	import net.richardlord.asteroids.components.Position;
	import net.richardlord.asteroids.nodes.RenderNode;


	public class RenderSystem extends System
	{
		[Inject]
		public var container : DisplayObjectContainer;
		
		[Inject(nodeType="net.richardlord.asteroids.nodes.RenderNode")]
		public var nodes : NodeList;

		override public function update( time : Number ) : void
		{
			var node : RenderNode;
			var position : Position;
			var display : Display;
			var displayObject : DisplayObject;

			for ( node = nodes.head; node; node = node.next )
			{
				display = node.display;
				displayObject = display.displayObject;
				position = node.position;

				if ( !displayObject.parent )
				{
					container.addChild( displayObject );
				}
				displayObject.x = position.position.x;
				displayObject.y = position.position.y;
				displayObject.rotation = position.rotation * 180 / Math.PI;
			}
		}
	}
}
