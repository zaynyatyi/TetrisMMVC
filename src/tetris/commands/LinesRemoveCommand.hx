package tetris.commands;

import mmvc.impl.Command;
import tetris.models.ElementModel;
import tetris.models.FieldModel;

class LinesRemoveCommand extends Command
{
	@inject public var fieldModel:FieldModel;

	public function new()
	{
		super();
	}

	override public function execute():Void
	{
		super.execute();
		for (rowIndex in 0...fieldModel.squares.length) {
			if (fieldModel.squares[rowIndex].indexOf(0) == -1) {
				moveFieldDown(rowIndex);
			}
		}
	}

	function moveFieldDown(rowIndex:Int):Void
	{
		while (rowIndex >= 0) {
			rowIndex--;
			fieldModel.squares[rowIndex + 1] = fieldModel.squares[rowIndex];
		}
		fieldModel.squares[0] = [];
		for (index in 0...Settings.instance.fieldColumns) fieldModel.squares[0].push(0);
	}
}
