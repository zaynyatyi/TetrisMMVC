package tetris.commands;

import mmvc.impl.Command;
import tetris.signals.MoveSignal;

class LoopCommand extends Command
{
	@inject public var moveSignal:MoveSignal;

	public function new()
	{
		super();
	}

	override public function execute():Void
	{
		super.execute();
		trace("Loop command executed");
		moveSignal.dispatch();
	}
}
