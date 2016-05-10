package tetris.views;

import mmvc.impl.Mediator;
import tetris.models.FieldModel;
import tetris.signals.viewUpdaters.UpdateFieldSignal;

class FieldViewMediator extends Mediator<FieldView>
{
	@inject public var updateFieldSignal:UpdateFieldSignal;
	@inject public var fieldModel:FieldModel;

	public function new()
	{
		super();
	}

	override public function onRegister():Void
	{
		super.onRegister();
		updateFieldSignal.add(handleUpdateField);
	}

	override public function onRemove():Void
	{
		super.onRemove();
		updateFieldSignal.remove(handleUpdateField);
	}

	function handleUpdateField():Void
	{
		view.setData(fieldModel, true);
	}
}
