package net.richardlord.ash.fsm
{
	public interface ComponentProvider
	{
		function getComponent() : *;
		function get identifier() : *;
	}
}
