package tetris.commands;

import mmvc.impl.Command;
import tetris.models.ElementModel;
import tetris.models.FieldModel;
import tetris.signals.ClearSignal;
import tetris.signals.ExtrudeSignal;
import tetris.signals.MoveSignal;
import tetris.signals.StackSignal;
import tetris.signals.viewUpdaters.FinishGameSignal;
import tetris.signals.viewUpdaters.UpdateFieldSignal;
import tetris.signals.viewUpdaters.UpdateStatsSignal;

/*
 * Mostly signals router command
 *
 * It will check if element should be created, could be moved or should be stacked
*/
class CheckStateCommand extends Command
{
	@inject public var updateFieldSignal:UpdateFieldSignal;
	@inject public var updateStatsSignal:UpdateStatsSignal;
	@inject public var finishGameSignal:FinishGameSignal;
	@inject public var extrudeSignal:ExtrudeSignal;
	@inject public var moveSignal:MoveSignal;
	@inject public var clearSignal:ClearSignal;
	@inject public var stackSignal:StackSignal;
	@inject public var fieldModel:FieldModel;

	public function new()
	{
		super();
	}

	override public function execute():Void
	{
		super.execute();
		if (fieldModel.isInitialized) {
			if (!fieldModel.isOverflowed) {
				if (fieldModel.elementModel.currentChunk == null) {
					extrudeSignal.dispatch();
				} else {
					if (isAbleToMove()) {
						moveSignal.dispatch();
					} else {
						stackSignal.dispatch();
					}
				}
			} else {
				finishGameSignal.dispatch();
			}
		}
	}

	function isAbleToMove():Bool
	{
		var result:Bool = true;
		if (fieldModel.elementModel.currentChunk != null) {
			var chunk:ElementModel = fieldModel.elementModel.currentChunk;
			if (chunk.y + chunk.height >= fieldModel.squares.length) {
				result = false;
			} else {
				for (rowIndex in 0...chunk.height) {
					for (columnIndex in 0...chunk.width) {
						var cellRow:Int = rowIndex + chunk.y;
						var cellColumnt:Int = columnIndex + chunk.x;
						if (cellRow >= 0) {
							if (chunk.field[rowIndex][columnIndex] != 0 &&
								fieldModel.squares[cellRow + 1][cellColumnt] == 1) {
								result = false;
							}
						}
					}
				}
			}
		}
		return result;
	}
}
