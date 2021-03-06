package tetris.models;

import mmvc.impl.Actor;
import tetris.models.ElementsModel;

//Contains current field state
class FieldModel extends Actor
{
	@inject public var elementsModel:ElementsModel;

	public var squares:Array<Array<Int>>;
	public var lastUpdate:Float = 0;
	public var isOverflowed:Bool = false;
	public var isInitialized:Bool = false;

	public function new()
	{
		super();
	}
}
