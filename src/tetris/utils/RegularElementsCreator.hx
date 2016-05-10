package tetris.utils;

import Settings.Chunk;
import tetris.models.ElementModel;

class RegularElementsCreator extends ElementsCreator
{
	public function new()
	{
		super();
	}

	override public function createElement():ElementModel
	{
		var randomChunkIndex = Std.int(Settings.instance.chunksCollection.length * Math.random());
		var data:Chunk = Settings.instance.chunksCollection[randomChunkIndex];
		var result:ElementModel = new ElementModel();
		for (row in data.field) {
			result.field.push(row.copy());
		}
		result.y = -result.height;
		result.x = Std.int((Settings.instance.fieldColumns - result.width) / 2);

		return result;
	}
}