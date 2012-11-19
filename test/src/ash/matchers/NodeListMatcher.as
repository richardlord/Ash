package ash.matchers
{
	import ash.core.Node;
	import ash.core.NodeList;
	import org.hamcrest.Description;
	import org.hamcrest.TypeSafeMatcher;


	public class NodeListMatcher extends TypeSafeMatcher
	{
		private var elementMatchers : Array;

		public function NodeListMatcher( elementMatchers : Array )
		{
			super( NodeList );
			this.elementMatchers = elementMatchers;
		}

		override public function matchesSafely( item : Object ) : Boolean
		{
			if( ! item is NodeList )
			{
				return false;
			}
			
			var nodes : NodeList = item as NodeList;
			var index : int = 0;
			for( var node : Node = nodes.head; node; node = node.next, ++index )
			{
				if( index >= elementMatchers.length )
				{
					return false;
				}
				if( ! elementMatchers[index].matches( node ) )
				{
					return false;
				}
			}

			return true;
		}

		override public function describeTo( description : Description ) : void
		{
			description.appendList( descriptionStart(), descriptionSeparator(), descriptionEnd(), elementMatchers );
		}

		protected function descriptionStart() : String
		{
			return "[";
		}

		protected function descriptionSeparator() : String
		{
			return ", ";
		}

		protected function descriptionEnd() : String
		{
			return "]";
		}
	}
}
