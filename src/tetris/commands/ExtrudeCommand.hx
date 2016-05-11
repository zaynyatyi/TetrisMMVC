package tetris.commands;

import mmvc.impl.Command;
import tetris.models.ElementsModel;
import tetris.models.FieldModel;
import tetris.signals.ErrorSignal;
import tetris.signals.viewUpdaters.UpdateStatsSignal;
import tetris.utils.ElementsCreator;

class ExtrudeCommand extends Command
{
	@inject public var errorSignal:ErrorSignal;
	@inject public var elementModel:ElementsModel;
	@inject public var elementsCreator:ElementsCreator;

	public function new()
	{
		super();
	}

	override public function execute():Void
	{
		super.execute();
		try {
			if (elementModel.nextChunk != null) {
				elementModel.currentChunk = elementModel.nextChunk;
			} else {
				elementModel.currentChunk = elementsCreator.createElement();
			}
			elementModel.nextChunk = elementsCreator.createElement();
		} catch (error:String) {
			trace ("Error in elements creation");
			errorSignal.dispatch();
		}
	}
}
