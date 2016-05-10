package tetris.commands;

import mmvc.impl.Command;
import tetris.models.ElementModel;
import tetris.models.FieldModel;
import tetris.signals.LinesRemoveSignal;

class StackCommand extends Command
{
	@inject public var linesRemoveSignal:LinesRemoveSignal;
	@inject public var fieldModel:FieldModel;

	public function new()
	{
		super();
	}

	override public function execute():Void
	{
		super.execute();
		var isOverflowed:Bool = false;
		if (fieldModel.elementModel.currentChunk != null) {
			var chunk:ElementModel = fieldModel.elementModel.currentChunk;
			for (rowIndex in 0...chunk.height) {
				for (columnIndex in 0...chunk.width) {
					var cellRow:Int = rowIndex + chunk.y;
					var cellColumnt:Int = columnIndex + chunk.x;
					if (cellRow >= 0) {
						if (chunk.field[rowIndex][columnIndex] != 0) {
							fieldModel.squares[rowIndex + chunk.y][columnIndex + chunk.x] = 1;
						}
					} else {
						isOverflowed = true;
					}
				}
			}
			fieldModel.elementModel.currentChunk = null;
		}
		if (isOverflowed) {
			fieldModel.isOverflowed = true;
		} else {
			linesRemoveSignal.dispatch();
		}
	}
}
