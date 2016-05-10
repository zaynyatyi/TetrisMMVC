package tetris.views;

import core.DataView;
import js.Browser;
import js.html.Element;
import js.html.Event;
import js.html.KeyboardEvent;
import tetris.models.StateModel;

/*
 * Game state view. It will request frame update (over mediator), show game over message.
 */
class StateView extends DataView<StateModel>
{
	public static inline var RESTART_SIGNAL:String = "state_restart";
	public static inline var MOVE_LEFT_SIGNAL:String = "state_move_left";
	public static inline var MOVE_RIGHT_SIGNAL:String = "state_move_right";
	public static inline var MOVE_DOWN_SIGNAL:String = "state_move_down";
	public static inline var ROTATE_SIGNAL:String = "state_rotate";

	var button:Element;

	public function new(?data:StateModel)
	{
		super(data);
	}

	override function initialize()
	{
		super.initialize();

		button = Browser.document.createElement("a");
		button.style.position = "relative";
		button.style.top = "100px";
		button.className = "button";
		button.innerHTML = "Start new game";
		button.onclick = handleClick;
		element.appendChild(button);

		Browser.window.onkeyup = handleKeyUp;
	}

	override function applyStyle():Void
	{
		element.style.textAlign = "center";
		element.style.backgroundColor = "rgba(0, 0, 0, 0.5)";
	}

	public function hide():Void
	{
		element.style.display = "none";
	}

	public function show():Void
	{
		element.style.display = "block";
	}

	public function release():Void
	{
		button.onclick = null;
		Browser.window.onkeyup = null;
	}

	function handleClick(event:Event):Void
	{
		dispatch(RESTART_SIGNAL, this);
	}

	function handleKeyUp(event:KeyboardEvent):Void
	{
		switch (event.keyCode) {
			case 40:
				dispatch(MOVE_DOWN_SIGNAL, this);
			case 39:
				dispatch(MOVE_RIGHT_SIGNAL, this);
			case 38:
				dispatch(ROTATE_SIGNAL, this);
			case 37:
				dispatch(MOVE_LEFT_SIGNAL, this);
		}
	}
}
