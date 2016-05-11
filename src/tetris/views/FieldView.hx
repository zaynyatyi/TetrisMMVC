package tetris.views;

import core.DataView;
import js.Browser;
import js.html.DivElement;
import js.html.Element;
import tetris.models.ElementModel;
import tetris.models.FieldModel;
import tetris.signals.LoopSignal;
import tetris.views.StatsView;

class FieldView extends DataView<FieldModel>
{
	static inline var CELL_TAG:String = "div";
	static inline var CELL_CLASS:String = "cell";
	static inline var NONACTIVE_CELL_CLASS:String = "nonactive-cell";
	static inline var ACTIVE_CELL_CLASS:String = "active-cell";

	public var statsView:StatsView;

	//Using cells pool since amount of elements is static and we don't need to re-create them on every render loop
	var cellsPool:Array<Array<Element>>;
	var previousHint:Array<Array<Int>>;

	public function new(?data:FieldModel)
	{
		super(data);
		cellsPool = [];
		for (rowIndex in 0...Settings.instance.fieldRows) {
			cellsPool.push([]);
			for (columnIndex in 0...Settings.instance.fieldColumns) {
				var cell:Element = Browser.document.createElement(CELL_TAG);
				cell.className = CELL_CLASS;
				cell.style.width = '${Settings.instance.squareWidth}px';
				cell.style.height = '${Settings.instance.squareHeight}px';
				cell.classList.add(NONACTIVE_CELL_CLASS);
				cell.style.left = '${Settings.instance.squareWidth * columnIndex}px';
				cell.style.top = '${Settings.instance.squareHeight * rowIndex}px';
				cellsPool[rowIndex].push(cell);
				element.appendChild(cell);
			}
		}
	}

	override function initialize()
	{
		super.initialize();

		statsView = new StatsView();
		addChild(statsView);
	}

	override function applyStyle():Void
	{
		var fieldWidth = Settings.instance.fieldColumns * Settings.instance.squareWidth;
		var fieldHeight = Settings.instance.fieldRows * Settings.instance.squareHeight;
		element.style.width = '${fieldWidth}px';
		element.style.height = '${fieldHeight}px';

		element.style.marginLeft = '${-fieldWidth / 2}px';
	}

	override function dataChanged()
	{
		super.dataChanged();
		//Drawing current stacked cells
		for (rowIndex in 0...data.squares.length) {
			for (columnIndex in 0...data.squares[rowIndex].length) {
				var cell:Element = cellsPool[rowIndex][columnIndex];
				if (data.squares[rowIndex][columnIndex] == 0) {
					cell.classList.remove(ACTIVE_CELL_CLASS);
					cell.classList.add(NONACTIVE_CELL_CLASS);
				} else {
					cell.classList.remove(NONACTIVE_CELL_CLASS);
					cell.classList.add(ACTIVE_CELL_CLASS);
				}
			}
		}
		//Drawing current moving element
		if (data.elementsModel.currentChunk != null) {
			var chunk:ElementModel = data.elementsModel.currentChunk;
			for (rowIndex in 0...chunk.height) {
				for (columnIndex in 0...chunk.width) {
					var cellRow:Int = rowIndex + chunk.y;
					var cellColumnt:Int = columnIndex + chunk.x;
					if (cellRow >= 0) {
						var cell:Element = cellsPool[rowIndex + chunk.y][columnIndex + chunk.x];
						if (chunk.field[rowIndex][columnIndex] != 0) {
							//Since all empty cells were deactiveted earlier we don't have to switch states, just activate obtained ones
							cell.classList.add(ACTIVE_CELL_CLASS);
						}
					}
				}
			}
		}
		//Basic hidden hint implementation. Will trace next element preview to console.
		if (previousHint == null || previousHint != data.elementsModel.nextChunk.field) {
			if (data.elementsModel.nextChunk != null) {
				trace("Hint: ");
				for (row in data.elementsModel.nextChunk.field) {
					trace(row.toString());
				}
				//Since we will redefine array instance in extrude task links to it will be changed too
				//so we have to compare just links to prevent repeating of outputs
				previousHint = data.elementsModel.nextChunk.field;
			}
		}
	}
}
