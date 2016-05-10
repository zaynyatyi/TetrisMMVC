package tetris.views;

import core.DataView;
import js.Browser;
import js.html.Element;
import tetris.models.StatsModel;

class StatsView extends DataView<StatsModel>
{
	static inline var STATS_WIDTH:Int = 200;
	static inline var STATS_HEIGHT:Int = 300;
	static inline var LABEL_TEXT:String = "Destroyed: ";

	var destroyedLabel:Element;

	public function new(?data:StatsModel)
	{
		super(data);
	}

	override function initialize()
	{
		super.initialize();
		destroyedLabel = Browser.document.createParagraphElement();
		destroyedLabel.innerText = LABEL_TEXT + 0;
		element.appendChild(destroyedLabel);
	}

	override function applyStyle():Void
	{
		element.style.width = '${STATS_WIDTH}px';
		element.style.height = '${STATS_HEIGHT}px';
		element.style.marginLeft = '100%';
	}

	override function dataChanged()
	{
		destroyedLabel.innerText = LABEL_TEXT + data.linesDestroyed;
	}
}
