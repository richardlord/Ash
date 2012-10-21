package net.richardlord.ash.fsm
{
	public class EntityState
	{
		internal var components : Vector.<*>;
		
		public function EntityState()
		{
			components = new Vector.<*>();
		}
		
		public function addComponent( component : * ) : EntityState
		{
			components.push( component );
			return this;
		}
		
		public function removeComponent( component : * ) : EntityState
		{
			var i : int = components.indexOf( component );
			if( i != -1 )
			{
				components.splice( i, 1 );
			}
			return this;
		}
		
		public function hasComponent( component : * ) : Boolean
		{
			var i : int = components.indexOf( component );
			return ( i != -1 );
		}
	}
}
