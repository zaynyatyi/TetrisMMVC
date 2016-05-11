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

	//Based on input data context will choose strategy or return false to indicate that action is impossible
	public function executeStrategy(actionType:String, fieldModel:FieldModel, direction:Int = 0):Bool
	{
		//we have to check if we have needed strategy and our passed model is not null
		if (strategies.exists(actionType) || fieldModel == null) {
			return strategies.get(actionType).modify(fieldModel.squares, fieldModel.elementsModel.currentChunk, direction);
		} else {
			return false;
		}
	}
}