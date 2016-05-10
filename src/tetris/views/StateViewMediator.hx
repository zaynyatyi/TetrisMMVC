package tetris.views;

import core.View;
import haxe.Timer;
import mmvc.impl.Mediator;
import tetris.signals.ClearSignal;
import tetris.signals.LoopSignal;
import tetris.signals.userInput.MoveDownSignal;
import tetris.signals.userInput.MoveLeftSignal;
import tetris.signals.userInput.MoveRightSignal;
import tetris.signals.userInput.RotateSignal;
import tetris.signals.viewUpdaters.FinishGameSignal;

class StateViewMediator extends Mediator<StateView>
{
	@inject public var loopSignal:LoopSignal;
	@inject public var finishGameSignal:FinishGameSignal;
	@inject public var clearSignal:ClearSignal;

	@inject public var moveRightSignal:MoveRightSignal;
	@inject public var moveLeftSignal:MoveLeftSignal;
	@inject public var moveDownSignal:MoveDownSignal;
	@inject public var rotateSignal:RotateSignal;

	var loopTimer:Timer;

	public function new()
	{
		super();
		loopTimer = new Timer(Std.int(1000 / Settings.instance.fps));
	}

	override public function onRegister():Void
	{
		super.onRegister();
		//using mediate() to store listeners for easy cleanup during removal
		mediate(view.signal.add(handleViewSignals));
		mediate(finishGameSignal.add(handleGameFinish));
		loopTimer.run = requestFrameUpdate;
	}

	override public function onRemove():Void
	{
		loopTimer.run = null;
		loopTimer.stop();
		var stateView:StateView = cast(view, StateView);
		stateView.release();
		super.onRemove();
	}

	function handleViewSignals(event:String, view:View):Void
	{
		switch(event) {
			case StateView.RESTART_SIGNAL:
				var stateView:StateView = cast(view, StateView);
				stateView.hide();
				clearSignal.dispatch();
			case StateView.ROTATE_SIGNAL:
				rotateSignal.dispatch();
			case StateView.MOVE_DOWN_SIGNAL:
				moveDownSignal.dispatch();
			case StateView.MOVE_LEFT_SIGNAL:
				moveLeftSignal.dispatch();
			case StateView.MOVE_RIGHT_SIGNAL:
				moveRightSignal.dispatch();
		}
	}

	function handleGameFinish():Void
	{
		var stateView:StateView = cast(view, StateView);
		stateView.show();
	}

	function requestFrameUpdate():Void
	{
		loopSignal.dispatch();
	}
}