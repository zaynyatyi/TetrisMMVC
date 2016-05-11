package tetris.utils;
import tetris.models.ElementModel;

//Abstract class for strategy
class ModifyStrategy
{
	public function new()
	{
	}

	public function modify(fieldSquares:Array<Array<Int>>, chunk:ElementModel, direction:Int = 0):Bool
	{
		//Throw added because that method should be overloaded in child classes
		throw "Extend modification strategy";
	}
}