package tetris.commands;

import mmvc.impl.Command;
import tetris.models.StateModel;
import tetris.signals.viewUpdaters.FinishGameSignal;

//Will finish game on any error signal
class HandleErrorCommand extends Command
{
	@inject public var finishGameSignal:FinishGameSignal;
	@inject public var stateModel:StateModel;

	public function new()
	{
		super();
	}

	override public function execute():Void
	{
		super.execute();
		stateModel.isError = true;
		finishGameSignal.dispatch();
	}
}
