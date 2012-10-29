package net.richardlord.ash.fsm
{
	import net.richardlord.ash.fsm.ComponentProvider;

	public class ComponentInstanceProvider implements ComponentProvider
	{
		private var instance : *;
		
		public function ComponentInstanceProvider( instance : * )
		{
			this.instance = instance;
		}
		
		public function getComponent() : *
		{
			return instance;
		}
		
		public function get identifier() : *
		{
			return instance;
		}
	}
}
