package tetris.utils;
import tetris.models.ElementModel;

class MoveStrategy extends ModifyStrategy
{
	public function new()
	{
		super();
	}

	override public function modify(fieldSquares:Array<Array<Int>>, chunk:ElementModel, direction:Int = 0):Bool
	{
		if (chunk == null) return false;

		var result = true;
		if (direction != 0) {
			//Normalize direction if somehow not 1 or -1 will be passed
			direction = direction > 0 ? 1 : -1;
			for (rowIndex in 0...chunk.height) {
				for (columnIndex in 0...chunk.width) {
					var cellRow:Int = rowIndex + chunk.y;
					var cellColumnt:Int = columnIndex + chunk.x;
					if (cellRow >= 0) {
						if (chunk.field[rowIndex][columnIndex] != 0) {
							if (direction < 0) {
								if(chunk.x == 0 || fieldSquares[cellRow][cellColumnt + direction] == 1) result = false;
							} else {
								if((chunk.x + chunk.width) == fieldSquares[0].length || fieldSquares[cellRow][cellColumnt + direction] == 1) result = false;
							}
						}
					}
				}
			}
			if (result) {
				chunk.x += direction;
			}
		}
		return result;
	}
}