package tetris.views;

import mmvc.impl.Mediator;
import tetris.models.FieldModel;
import tetris.models.StatsModel;
import tetris.signals.viewUpdaters.UpdateFieldSignal;
import tetris.signals.viewUpdaters.UpdateStatsSignal;

class FieldViewMediator extends Mediator<FieldView>
{
	@inject public var updateFieldSignal:UpdateFieldSignal;
	@inject public var updateStatsSignal:UpdateStatsSignal;
	@inject public var fieldModel:FieldModel;
	@inject public var statsModel:StatsModel;

	public function new()
	{
		super();
	}

	override public function onRegister():Void
	{
		super.onRegister();
		mediate(updateFieldSignal.add(handleUpdateField));
		//Since stats view is part of fields view all stats update signals will be catched here
		mediate(updateStatsSignal.add(handleUpdateStats));
	}

	override public function onRemove():Void
	{
		super.onRemove();
	}

	function handleUpdateField():Void
	{
		view.setData(fieldModel, true);
	}

	function handleUpdateStats():Void
	{
		//we have to cast to pass updated data to child view
		cast(view, FieldView).statsView.setData(statsModel, true);
	}
}
