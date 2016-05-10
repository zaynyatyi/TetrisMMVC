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
		if (chunk == null) return false;

		var canRotate:Bool = true;
		var rotatedChunkField:Array<Array<Int>> = rotateClockwise(chunk.field);
		for (rowIndex in 0...rotatedChunkField.length) {
			for (columnIndex in 0...rotatedChunkField[rowIndex].length) {
				var fieldXPosition:Int = chunk.x + columnIndex;
				var fieldYPosition:Int = chunk.y + rowIndex;
				//You cant rotate if not whole element on field or it will be over limits after rotation or it will overlap with stacked cells after rotation
				if (chunk.y < 0 ||
					fieldXPosition > fieldSquares[0].length ||
					fieldYPosition > fieldSquares.length ||
					(fieldSquares[fieldYPosition][fieldXPosition] != 0 && rotatedChunkField[rowIndex][columnIndex] != 0)) {
					canRotate = false;
				}
			}
		}
		if (canRotate) {
			chunk.field = rotatedChunkField;
		}
		return canRotate;
	}

	function rotateClockwise(input:Array<Array<Int>>):Array<Array<Int>>
	{
		var result:Array<Array<Int>> = [];
		if (input.length > 0) {
			for (row in input[0]) {
				result.push([]);
			}
			for (columnIndex in 0...input[0].length) {
				for (rowIndex in 0...input.length) {
					var requestedRow:Int = input.length - rowIndex - 1;
					result[columnIndex].push(input[requestedRow][columnIndex]);
				}
			}
		}

		return result;
	}
}