package app;

import app.ApplicationView;
import app.ApplicationViewMediator;
import mmvc.api.IViewContainer;
import mmvc.impl.Context;
import tetris.commands.CheckStateCommand;
import tetris.commands.ClearCommand;
import tetris.commands.ExtrudeCommand;
import tetris.commands.LinesRemoveCommand;
import tetris.commands.LoopCommand;
import tetris.commands.MoveCommand;
import tetris.commands.StackCommand;
import tetris.commands.userInput.MoveDownCommand;
import tetris.commands.userInput.MoveLeftCommand;
import tetris.commands.userInput.MoveRightCommand;
import tetris.commands.userInput.RotateCommand;
import tetris.models.ElementsModel;
import tetris.models.FieldModel;
import tetris.models.StateModel;
import tetris.signals.CheckStateSignal;
import tetris.signals.ClearSignal;
import tetris.signals.ExtrudeSignal;
import tetris.signals.LinesRemoveSignal;
import tetris.signals.LoopSignal;
import tetris.signals.MoveSignal;
import tetris.signals.StackSignal;
import tetris.signals.userInput.MoveDownSignal;
import tetris.signals.userInput.MoveLeftSignal;
import tetris.signals.userInput.MoveRightSignal;
import tetris.signals.userInput.RotateSignal;
import tetris.signals.viewUpdaters.FinishGameSignal;
import tetris.signals.viewUpdaters.UpdateFieldSignal;
import tetris.signals.viewUpdaters.UpdateStatsSignal;
import tetris.utils.ElementsCreator;
import tetris.utils.ModificationContext;
import tetris.utils.RegularElementsCreator;
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
		commandMap.mapSignalClass(StackSignal, StackCommand);
		commandMap.mapSignalClass(LinesRemoveSignal, LinesRemoveCommand);
		commandMap.mapSignalClass(ClearSignal, ClearCommand);
		commandMap.mapSignalClass(CheckStateSignal, CheckStateCommand);
		commandMap.mapSignalClass(ExtrudeSignal, ExtrudeCommand);
		//Mapping user input related signals
		commandMap.mapSignalClass(MoveLeftSignal, MoveLeftCommand);
		commandMap.mapSignalClass(MoveRightSignal, MoveRightCommand);
		commandMap.mapSignalClass(MoveDownSignal, MoveDownCommand);
		commandMap.mapSignalClass(RotateSignal, RotateCommand);

		//Mapping signals which will be used by mediators to update related views
		injector.mapSingleton(UpdateStatsSignal);
		injector.mapSingleton(UpdateFieldSignal);
		injector.mapSingleton(FinishGameSignal);

		//Mapping models
		injector.mapSingleton(ElementsModel);
		injector.mapSingleton(FieldModel);
		injector.mapSingleton(StateModel);

		//Mapping views and mediators
		mediatorMap.mapView(FieldView, FieldViewMediator);
		mediatorMap.mapView(StateView, StateViewMediator);

		//Mapping utility classes
		//Tetris elements factory so if we will need to change created elements we will need to remap it to another factory class
		//We can also have few factories (to implement some extra types of elemnts), but they should be mapped as different instances
		injector.mapSingletonOf(ElementsCreator, RegularElementsCreator);
		//Tetris elemnts strategy context mapping
		injector.mapSingleton(ModificationContext);

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