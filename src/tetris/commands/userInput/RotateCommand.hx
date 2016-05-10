package tetris.commands.userInput;

import mmvc.impl.Command;
import tetris.models.FieldModel;
import tetris.signals.viewUpdaters.UpdateFieldSignal;
import tetris.utils.ModificationContext;

class RotateCommand extends Command
{
	@inject public var updateFieldSignal:UpdateFieldSignal;
	@inject public var fieldModel:FieldModel;
	@inject public var modificationContext:ModificationContext;

	public function new()
	{
		super();
	}

	override public function execute():Void
	{
		super.execute();
		if(modificationContext.executeStrategy(ModificationContext.MOVE, fieldModel, 1)) updateFieldSignal.dispatch();
	}
}
