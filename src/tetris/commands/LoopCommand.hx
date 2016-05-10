package tetris.commands;

import mmvc.impl.Command;
import tetris.models.StateModel;
import tetris.signals.CheckStateSignal;

class LoopCommand extends Command
{
	@inject public var stateModel:StateModel;
	@inject public var checkStateSignal:CheckStateSignal;

	public function new()
	{
		super();
	}

	override public function execute():Void
	{
		super.execute();
		//We have to trigger move signal if we are in play mode only
		if (!stateModel.isGameover) checkStateSignal.dispatch();
	}
}
