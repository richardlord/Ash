package ash.matchers
{
	import org.hamcrest.Matcher;

	public function nodeList( ... params ) : Matcher
	{
		var matchers : Array = params;

		if (params.length == 1 && params[0] is Array)
		{
			matchers = params[0];
		}

		var elementMatchers : Array = matchers.map( wrapInEqualToIfNotMatcher );

		return new NodeListMatcher( elementMatchers );
	}
}

import org.hamcrest.Matcher;
import org.hamcrest.object.equalTo;

internal function wrapInEqualToIfNotMatcher( item : Object, i : int, a : Array ) : Matcher
{
	return item is Matcher ? item as Matcher : equalTo( item );
}
