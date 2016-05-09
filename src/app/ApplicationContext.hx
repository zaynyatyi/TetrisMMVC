package app;

import app.ApplicationView;
import app.ApplicationViewMediator;
import mmvc.api.IViewContainer;
import mmvc.impl.Context;
import tetris.commands.CheckStateCommand;
import tetris.commands.ClearCommand;
import tetris.commands.ExtrudeCommand;
import tetris.commands.LoopCommand;
import tetris.commands.MoveCommand;
import tetris.models.FieldModel;
import tetris.models.StateModel;
import tetris.signals.CheckStateSignal;
import tetris.signals.ClearSignal;
import tetris.signals.ExtrudeSignal;
import tetris.signals.LoopSignal;
import tetris.signals.MoveSignal;
import tetris.views.FieldView;
import tetris.views.FieldViewMediator;
import tetris.views.StateView;
import tetris.views.StateViewMediator;

class ApplicationContext extends Context
{
	public function new(?contextView:IViewContainer = null, ?autoStartup:Bool = true)
	{
		super(contextView, autoStartup);
	}

	override public function startup():Void
	{
		trace("Starting up");
		//Mapping commands and signals
		commandMap.mapSignalClass(LoopSignal, LoopCommand);
		commandMap.mapSignalClass(MoveSignal, MoveCommand);
		commandMap.mapSignalClass(ClearSignal, ClearCommand);
		commandMap.mapSignalClass(CheckStateSignal, CheckStateCommand);
		commandMap.mapSignalClass(ExtrudeSignal, ExtrudeCommand);

		injector.mapSingleton(FieldModel);
		mediatorMap.mapView(FieldView, FieldViewMediator);
		injector.mapSingleton(StateModel);
		mediatorMap.mapView(StateView, StateViewMediator);

		//Wiring for main application module
		mediatorMap.mapView(ApplicationView, ApplicationViewMediator);
	}

	/**
	Overrides shutdown to remove/cleanup mappings
	@see mmvc.impl.Context
	*/
	override public function shutdown()
	{
	}
}