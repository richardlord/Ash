package net.richardlord.ash.fsm
{
	public interface ComponentProvider
	{
		function get component() : *;
		function get identifier() : *;
	}
}
