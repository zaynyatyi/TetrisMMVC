package tetris.models;

import mmvc.impl.Actor;

class StateModel extends Actor
{
	public var isGameover:Bool = false;
	public var isError:Bool = false;

	public function new()
	{
		super();
	}
}
