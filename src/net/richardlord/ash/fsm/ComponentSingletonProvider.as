package net.richardlord.ash.fsm
{
	import net.richardlord.ash.fsm.ComponentProvider;

	public class ComponentSingletonProvider implements ComponentProvider
	{
		private var componentType : Class;
		private var instance : *;
		
		public function ComponentSingletonProvider( type : Class )
		{
			this.componentType = type;
		}
		
		public function get component() : *
		{
			if( !instance )
			{
				instance = new componentType();
			}
			return instance;
		}
		
		public function get identifier() : *
		{
			return component;
		}
	}
}
