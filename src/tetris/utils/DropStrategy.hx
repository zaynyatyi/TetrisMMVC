package tetris.utils;
import tetris.models.ElementModel;

class DropStrategy extends ModifyStrategy
{
	public function new()
	{
		super();
	}

	override public function modify(fieldSquares:Array<Array<Int>>, chunk:ElementModel, direction:Int = 0):Bool
	{
		var result = true;
		if (chunk.y + chunk.height >= fieldSquares.length) {
			result = false;
		} else {
			for (rowIndex in 0...chunk.height) {
				for (columnIndex in 0...chunk.width) {
					var cellRow:Int = rowIndex + chunk.y;
					var cellColumnt:Int = columnIndex + chunk.x;
					if (cellRow >= 0) {
						if (chunk.field[rowIndex][columnIndex] != 0 &&
							fieldSquares[cellRow + 1][cellColumnt] == 1) {
							result = false;
						}
					}
				}
			}
		}
		if (result) {
			chunk.y++;
		}
		return result;
	}
}