package net.richardlord.ash.fsm
{
	public class ComponentMapping
	{
		private var componentType : Class;
		private var creatingState : EntityState;
		private var provider : ComponentProvider;
		
		public function ComponentMapping( creatingState : EntityState, type : Class )
		{
			this.creatingState = creatingState;
			componentType = type;
			withType( type );
		}
		
		public function withInstance( component : * ) : ComponentMapping
		{
			setProvider( new ComponentInstanceProvider( component ) );
			return this;
		}
		
		public function withType( type : Class ) : ComponentMapping
		{
			setProvider( new ComponentTypeProvider( type ) );
			return this;
		}
		
		public function withSingleton( type : Class = null ) : ComponentMapping
		{
			setProvider( new ComponentSingletonProvider( type ) );
			return this;
		}
		
		public function withProvider( provider : ComponentProvider ) : ComponentMapping
		{
			setProvider( provider );
			return this;
		}
		
		private function setProvider( provider : ComponentProvider ) : void
		{
			this.provider = provider;
			creatingState.providers[ componentType ] = provider;
		}
		
		public function add( type : Class ) : ComponentMapping
		{
			return creatingState.add( type );
		}
	}
}
