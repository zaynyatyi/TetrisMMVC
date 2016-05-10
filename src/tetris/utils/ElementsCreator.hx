package tetris.utils;

import Settings.Chunk;
import tetris.models.ElementModel;

class ElementsCreator
{
	public function new()
	{
	}

	public function createElement():ElementModel
	{
		throw "Extend elements creator for concrete implementation";
	}
}