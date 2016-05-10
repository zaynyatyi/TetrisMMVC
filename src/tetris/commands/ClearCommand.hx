package tetris.commands;

import mmvc.impl.Command;
import tetris.models.FieldModel;

class ClearCommand extends Command
{
	@inject public var fieldModel:FieldModel;

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
	}
}
