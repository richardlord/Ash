package ash
{
	import asunit.core.TextCore;

	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;

	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="800", height="600")]
	
	final public class TestRunner extends Sprite
	{
		public function TestRunner()
		{
			var core:TextCore = new TextCore();
			core.start(AllTests, null, this);
		}
	}
}
