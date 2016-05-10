package tetris.utils;
import tetris.models.FieldModel;

class ModificationContext
{
	public static inline var DROP:String = "drop";
	public static inline var MOVE:String = "move";
	public static inline var ROTATE:String = "rotate";

	var strategies:Map<String, ModifyStrategy>;

	public function new()
	{
		strategies = new Map();
		strategies.set(DROP, new DropStrategy());
		strategies.set(MOVE, new MoveStrategy());
		strategies.set(ROTATE, new RotateStrategy());
	}

	public function executeStrategy(actionType:String, fieldModel:FieldModel, direction:Int = 0):Bool
	{
		if (strategies.exists(actionType)) {
			return strategies.get(actionType).modify(fieldModel.squares, fieldModel.elementModel.currentChunk, direction);
		} else {
			return false;
		}
	}
}