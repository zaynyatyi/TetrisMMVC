package tetris.views;

import haxe.Timer;
import mmvc.impl.Mediator;
import tetris.signals.LoopSignal;

class StateViewMediator extends Mediator<StateView>
{
	@inject public var loopSignal:LoopSignal;

	var loopTimer:Timer;

	public function new()
	{
		super();
		loopTimer = new Timer(Std.int(1000 / Settings.instance.fps));
	}

	override public function onRegister():Void
	{
		super.onRegister();
		loopTimer.run = requestFrameUpdate;
	}

	override public function onRemove():Void
	{
		super.onRemove();
		loopTimer.run = null;
		loopTimer.stop();
	}

	function requestFrameUpdate():Void
	{
		loopSignal.dispatch();
	}
}