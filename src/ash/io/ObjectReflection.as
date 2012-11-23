package ash.io
{
	import flash.utils.describeType;
	import flash.utils.getQualifiedClassName;

	public class ObjectReflection
	{
		private var _propertyTypes : Object = {};
		private var _type : String;

		public function ObjectReflection( component : Object )
		{
			_type = getQualifiedClassName( component );
			var description : XML = describeType( component );
			var list : XMLList = description.variable;
			for each ( var xml:XML in list )
			{
				_propertyTypes[ xml.@name.toString() ] = xml.@type.toString();
			}
			list = description.accessor.(@access == "readwrite");
			for each ( xml in list)
			{
				_propertyTypes[ xml.@name.toString() ] = xml.@type.toString();
			}
		}

		public function get propertyTypes() : Object
		{
			return _propertyTypes;
		}

		public function get type() : String
		{
			return _type;
		}
	}
}
