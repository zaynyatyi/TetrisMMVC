package tetris.models;

class ElementModel
{
	public var x:Int;
	public var y:Int;
	public var field:Array<Array<Int>>;
	public var width(get, null):Int;
	public var height(get, null):Int;

	public function new()
	{
		field = [];
	}

	function get_width():Int
	{
		//Since all elemnts should fit square field we hace to return only first row length to get element width
		if (field.length != 0) {
			return field[0].length;
		} else {
			return 0;
		}
	}

	function get_height():Int
	{
		return field.length;
	}
}
