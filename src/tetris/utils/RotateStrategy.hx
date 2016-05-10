package tetris.utils;
import tetris.models.ElementModel;

class RotateStrategy extends ModifyStrategy
{
	public function new()
	{
		super();
	}

	override public function modify(fieldSquares:Array<Array<Int>>, chunk:ElementModel, direction:Int = 0):Bool
	{
		throw "Extend modification strategy";
	}
}