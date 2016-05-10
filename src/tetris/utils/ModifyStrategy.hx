package tetris.utils;
import tetris.models.ElementModel;

class ModifyStrategy
{
	public function new()
	{
	}

	public function modify(fieldSquares:Array<Array<Int>>, chunk:ElementModel, direction:Int = 0):Bool
	{
		throw "Extend modification strategy";
	}
}