package app;

import app.ApplicationView;
import mmvc.impl.Mediator;

class ApplicationViewMediator extends Mediator<ApplicationView>
{
	public function new()
	{
		super();
	}

	/**
	Context has now been initialized. Time to create the rest of the main views in the application
	@see mmvc.impl.Mediator.onRegister()
	*/
	override function onRegister():Void
	{
		super.onRegister();
		view.createViews();
	}

	/**
	@see mmvc.impl.Mediator
	*/
	override public function onRemove():Void
	{
		super.onRemove();
	}
}