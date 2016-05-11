package tetris.views;

import core.View;
import haxe.Timer;
import mmvc.impl.Mediator;
import tetris.models.StateModel;
import tetris.signals.ClearSignal;
import tetris.signals.ErrorSignal;
import tetris.signals.LoopSignal;
import tetris.signals.userInput.MoveDownSignal;
import tetris.signals.userInput.MoveLeftSignal;
import tetris.signals.userInput.MoveRightSignal;
import tetris.signals.userInput.RotateSignal;
import tetris.signals.viewUpdaters.FinishGameSignal;

//That mediator will catch all state changes (User input, render frame requests)
class StateViewMediator extends Mediator<StateView>
{
	@inject public var loopSignal:LoopSignal;
	@inject public var finishGameSignal:FinishGameSignal;
	@inject public var errorSignal:ErrorSignal;
	@inject public var clearSignal:ClearSignal;

	@inject public var moveRightSignal:MoveRightSignal;
	@inject public var moveLeftSignal:MoveLeftSignal;
	@inject public var moveDownSignal:MoveDownSignal;
	@inject public var rotateSignal:RotateSignal;

	@inject public var stateModel:StateModel;

	var loopTimer:Timer;

	public function new()
	{
		super();
		//We have to reuest updates from view since it's "user" action
		//It will be easy to implement step by step update based on user input in that way
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
		//we have to release timer to prevent memory leak
		loopTimer.run = null;
		loopTimer.stop();
		//we have to release all views callback to prevent memory leak
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
		if (stateModel.isError) {
			view.setData(stateModel, true);
			loopTimer.run = null;
			loopTimer.stop();
		}
	}

	function requestFrameUpdate():Void
	{
		loopSignal.dispatch();
	}
}