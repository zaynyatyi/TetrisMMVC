package app;

import core.View;
import mmvc.api.IViewContainer;
import tetris.views.FieldView;
import tetris.views.StateView;
import tetris.views.StatsView;

class ApplicationView extends View implements IViewContainer
{
	public var viewAdded:Dynamic -> Void;
	public var viewRemoved:Dynamic -> Void;

	public function new()
	{
		super();
	}

	/**
	Called by ApplicationViewMediator once application is wired up to the context
	@see ApplicationViewMediator.onRegister;
	*/
	public function createViews()
	{
		var fieldView:FieldView = new FieldView();
		addChild(fieldView);
		var statsView:StatsView = new StatsView();
		addChild(statsView);
		var stateView:StateView = new StateView();
		addChild(stateView);
	}

	/**
	Overrides signal bubbling to trigger view added/removed handlers for IViewContainer
	@param event 	a string event type
	@param view 	instance of view that originally dispatched the event
	*/
	override public function dispatch(event:String, view:View)
	{
		switch(event) {
			case View.ADDED:
				viewAdded(view);
			case View.REMOVED:
				viewRemoved(view);
			case _:
				super.dispatch(event, view);
		}
	}

	/**
	Required by IViewContainer
	*/
	public function isAdded(view:Dynamic):Bool
	{
		return true;
	}

	/**
	Overrides View.initialize to add to top level platform specific sprite/element
	*/
	override function initialize()
	{
		super.initialize();
		#if flash
		flash.Lib.current.addChild(sprite);
		#elseif js
		js.Browser.document.body.appendChild(element);
		#end
	}
}