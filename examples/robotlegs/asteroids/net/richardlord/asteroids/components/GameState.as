package net.richardlord.asteroids.components
{
	public class GameState
	{
		public var lives : int = 0;
		public var level : int = 0;
		public var points : int = 0;
		public var width : Number = 0;
		public var height : Number = 0;
		
		public function GameState( width : Number = 0, height : Number = 0 )
		{
			this.width = width;
			this.height = height;
		}
	}
}
