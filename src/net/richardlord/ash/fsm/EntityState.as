package net.richardlord.ash.fsm
{
	import flash.utils.Dictionary;

	public class EntityState
	{
		internal var providers : Dictionary = new Dictionary();

		public function add( type : Class ) : ComponentMapping
		{
			return new ComponentMapping( this, type );
		}
		
		public function get( type : Class ) : ComponentProvider
		{
			return providers[ type ];
		}
		
		public function has( type : Class ) : Boolean
		{
			return providers[ type ] != null;
		}
	}
}
