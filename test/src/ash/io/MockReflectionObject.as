package ash.io
{
	import flash.geom.Point;
	
	public class MockReflectionObject
	{
		public var intVariable : int;
		public var uintVariable : uint;
		public var numberVariable : Number;
		public var booleanVariable : Boolean;
		public var stringVariable : String;
		public var pointVariable : Point;
		
		private var _fullAccessor : int;

		public function get fullAccessor() : int
		{
			return _fullAccessor;
		}

		public function set fullAccessor( value : int ) : void
		{
			_fullAccessor = value;
		}

		public function get getOnlyAccessor() : int
		{
			return 1;
		}

		public function set setOnlyAccessor( value : int ) : void
		{
		}
	}
}
