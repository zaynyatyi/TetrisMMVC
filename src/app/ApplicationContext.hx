package app;

import app.ApplicationView;
import app.ApplicationViewMediator;
import mmvc.api.IViewContainer;
import mmvc.impl.Context;

class ApplicationContext extends Context
{
	public function new(?contextView:IViewContainer = null, ?autoStartup:Bool = true)
	{
		super(contextView, autoStartup);
	}

	override public function startup():Void
	{
		// wiring for main application module
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