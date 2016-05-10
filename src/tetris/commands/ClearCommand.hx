package tetris.commands;

import mmvc.impl.Command;
import tetris.models.FieldModel;
import tetris.models.StatsModel;
import tetris.signals.viewUpdaters.UpdateFieldSignal;
import tetris.signals.viewUpdaters.UpdateStatsSignal;

class ClearCommand extends Command
{
	@inject public var updateStatsSignal:UpdateStatsSignal;
	@inject public var updateFieldSignal:UpdateFieldSignal;
	@inject public var fieldModel:FieldModel;
	@inject public var statsModel:StatsModel;

	public function new()
	{
		super();
	}

	override public function execute():Void
	{
		super.execute();
		fieldModel.isInitialized = true;
		fieldModel.isOverflowed = false;
		fieldModel.squares = [];
		for (row in 0...Settings.instance.fieldRows) {
			fieldModel.squares.push([]);
			for (column in 0...Settings.instance.fieldColumns) {
				fieldModel.squares[row].push(0);
			}
		}
		statsModel.linesDestroyed = 0;
		updateStatsSignal.dispatch();
		updateFieldSignal.dispatch();
	}
}
