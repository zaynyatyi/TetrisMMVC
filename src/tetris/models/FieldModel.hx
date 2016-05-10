package tetris.models;

import mmvc.impl.Actor;
import tetris.models.ElementsModel;

class FieldModel extends Actor
{
	@inject public var elementModel:ElementsModel;

	public var squares:Array<Array<Int>>;
	public var lastUpdate:Float = 0;
	public var isOverflowed:Bool = false;
	public var isInitialized:Bool = false;

	public function new()
	{
		super();
	}
}
