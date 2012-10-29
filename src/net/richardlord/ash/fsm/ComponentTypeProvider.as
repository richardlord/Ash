package net.richardlord.ash.fsm
{
	import net.richardlord.ash.fsm.ComponentProvider;

	public class ComponentTypeProvider implements ComponentProvider
	{
		private var componentType : Class;
		
		public function ComponentTypeProvider( type : Class )
		{
			this.componentType = type;
		}
		
		public function getComponent() : *
		{
			return new componentType();
		}
		
		public function get identifier() : *
		{
			return componentType;
		}
	}
}
