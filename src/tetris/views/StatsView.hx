package tetris.views;

import core.DataView;
import tetris.models.StatsModel;

class StatsView extends DataView<StatsModel>
{
	static inline var STATS_WIDTH:Int = 200;
	static inline var STATS_HEIGHT:Int = 300;

	public function new(?data:StatsModel)
	{
		super(data);
	}

	override function applyStyle():Void
	{
		element.style.width = '${STATS_WIDTH}px';
		element.style.height = '${STATS_HEIGHT}px';
		element.style.marginLeft = '100%';
	}
}
