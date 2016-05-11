package tetris.commands;

import mmvc.impl.Command;
import tetris.models.FieldModel;
import tetris.signals.viewUpdaters.UpdateFieldSignal;

class MoveCommand extends Command
{
	@inject public var updateFieldSignal:UpdateFieldSignal;
	@inject public var fieldModel:FieldModel;

	public function new()
	{
		super();
	}

	//It will move anyway because moving ability check is outside of that task
	//Just checks if it's time for automatic movement
	override public function execute():Void
	{
		super.execute();
		var currentTimestamp:Float = Date.now().getTime();
		if (currentTimestamp - fieldModel.lastUpdate >= Settings.instance.moveDelay) {
			fieldModel.lastUpdate = currentTimestamp;
			if (fieldModel.elementsModel.currentChunk != null) {
				fieldModel.elementsModel.currentChunk.y++;
				updateFieldSignal.dispatch();
			} else {
				//If move signal was fired without element extruded for some reason
				trace("Error: attempt to move unexisted element");
			}
		}
	}
}
