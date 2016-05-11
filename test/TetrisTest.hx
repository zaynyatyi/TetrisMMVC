package;

import massive.munit.Assert;
import msignal.Signal.Signal0;
import tetris.commands.ClearCommand;
import tetris.commands.ExtrudeCommand;
import tetris.commands.LinesRemoveCommand;
import tetris.commands.MoveCommand;
import tetris.commands.StackCommand;
import tetris.commands.userInput.RotateCommand;
import tetris.models.ElementModel;
import tetris.models.ElementsModel;
import tetris.models.FieldModel;
import tetris.models.StateModel;
import tetris.models.StatsModel;
import tetris.utils.ModificationContext;
import tetris.utils.RegularElementsCreator;

class TetrisTest
{
	static var EMPTY:Array<Array<Int>> = [
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
	];

	static var FILLED:Array<Array<Int>> = [
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 1, 0, 0, 0, 0, 0, 0, 1, 0],
		[1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
		[1, 1, 1, 1, 1, 1, 0, 1, 1, 1]
	];

	static var MODIFIED:Array<Array<Int>> = [
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 1, 0, 0, 0, 0, 0, 0, 1, 0],
		[1, 1, 1, 1, 1, 1, 0, 1, 1, 1]
	];

	static var STACKED:Array<Array<Int>> = [
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
		[0, 0, 0, 0, 0, 0, 0, 1, 1, 0],
		[0, 1, 0, 0, 0, 0, 0, 1, 1, 0],
		[1, 1, 1, 1, 1, 1, 0, 1, 1, 1]
	];

	static var ELEMENT_FIELD:Array<Array<Int>> = [
		[1, 1],
		[1, 0]
	];

	static var ROTATED_ELEMENT_FIELD:Array<Array<Int>> = [
		[1, 1],
		[0, 1]
	];

	static var INITIAL_X:Int = 7;
	static var INITIAL_Y:Int = 16;
	static var MOVED_Y:Int = 17;

	var fieldModel:FieldModel;
	var stateModel:StateModel;
	var statsModel:StatsModel;
	var elementsModel:ElementsModel;
	var signalPlaceholder:Signal0;

	public function new()
	{
	}

	@BeforeClass
	public function beforeClass():Void
	{
	}

	@AfterClass
	public function afterClass():Void
	{
	}

	@Before
	public function setup():Void
	{
		//Just a placeholder for all signals since we will not test gameflow
		signalPlaceholder = new Signal0();

		fieldModel = new FieldModel();
		stateModel = new StateModel();
		statsModel = new StatsModel();
		elementsModel = new ElementsModel();

		fieldModel.elementsModel = elementsModel;
	}

	@After
	public function tearDown():Void
	{
	}

	@Test
	public function initializationTest():Void
	{
		statsModel.linesDestroyed = 1; //Just a not null value
		Assert.isFalse(fieldModel.isInitialized);
		Assert.isNull(fieldModel.squares, null);
		Assert.areNotEqual(statsModel.linesDestroyed, 0);
		clearModels();
		Assert.isTrue(fieldModel.isInitialized);
		Assert.areEqual(statsModel.linesDestroyed, 0);
		Assert.isNotNull(fieldModel.squares);
		Assert.areEqual(fieldModel.squares.length, Settings.instance.fieldRows);
		Assert.areEqual(fieldModel.squares[0].length, Settings.instance.fieldColumns);
	}

	@Test
	public function extrusionTest():Void
	{
		fieldModel.elementsModel = new ElementsModel();
		Assert.isNull(fieldModel.elementsModel.currentChunk);
		Assert.isNull(fieldModel.elementsModel.nextChunk);
		var extrudeCommand:ExtrudeCommand = new ExtrudeCommand();
		extrudeCommand.elementModel = fieldModel.elementsModel;
		extrudeCommand.elementsCreator = new RegularElementsCreator();
		extrudeCommand.execute();
		Assert.isNotNull(fieldModel.elementsModel.currentChunk);
		Assert.isNotNull(fieldModel.elementsModel.nextChunk);
	}

	@Test
	public function movingTest():Void
	{
		clearModels();
		fieldModel.elementsModel.currentChunk = new ElementModel();
		fieldModel.elementsModel.currentChunk.field = ELEMENT_FIELD;
		fieldModel.elementsModel.currentChunk.x = INITIAL_X;
		fieldModel.elementsModel.currentChunk.y = INITIAL_Y;
		var moveCommand:MoveCommand = new MoveCommand();
		moveCommand.fieldModel = fieldModel;
		moveCommand.updateFieldSignal = cast signalPlaceholder;
		fieldModel.lastUpdate = 0;
		moveCommand.execute();
		Assert.areEqual(fieldModel.elementsModel.currentChunk.y, INITIAL_Y + 1);
	}

	@Test
	public function linesRemovingTest():Void
	{
		clearModels();
		fieldModel.squares = FILLED;
		var linesCount:Int = statsModel.linesDestroyed;
		Assert.isFalse(compareArrays(fieldModel.squares, MODIFIED));
		var linesRemoveCommand:LinesRemoveCommand = new LinesRemoveCommand();
		linesRemoveCommand.fieldModel = fieldModel;
		linesRemoveCommand.statsModel = statsModel;
		linesRemoveCommand.updateStatsSignal = cast signalPlaceholder;
		linesRemoveCommand.execute();
		Assert.isTrue(compareArrays(fieldModel.squares, MODIFIED));
		Assert.areEqual(statsModel.linesDestroyed, linesCount + 1);
	}

	@Test
	public function stackingTest():Void
	{
		clearModels();
		fieldModel.squares = MODIFIED;
		fieldModel.elementsModel.currentChunk = new ElementModel();
		fieldModel.elementsModel.currentChunk.field = ELEMENT_FIELD;
		fieldModel.elementsModel.currentChunk.x = INITIAL_X;
		fieldModel.elementsModel.currentChunk.y = MOVED_Y;
		var stackCommand:StackCommand = new StackCommand();
		stackCommand.fieldModel = fieldModel;
		stackCommand.linesRemoveSignal = cast signalPlaceholder;
		stackCommand.execute();
		Assert.isTrue(compareArrays(fieldModel.squares, STACKED));
	}

	@Test
	public function elementMovingTest():Void
	{
		clearModels();
	}

	@Test
	public function elementRotationTest():Void
	{
		clearModels();
		fieldModel.squares = FILLED;
		fieldModel.elementsModel.currentChunk = new ElementModel();
		fieldModel.elementsModel.currentChunk.field = ELEMENT_FIELD;
		fieldModel.elementsModel.currentChunk.x = INITIAL_X;
		fieldModel.elementsModel.currentChunk.y = INITIAL_Y;
		var rotateCommand:RotateCommand = new RotateCommand();
		rotateCommand.modificationContext = new ModificationContext();
		rotateCommand.fieldModel = fieldModel;
		rotateCommand.updateFieldSignal = cast signalPlaceholder;
		rotateCommand.execute();
		Assert.isTrue(compareArrays(fieldModel.elementsModel.currentChunk.field, ELEMENT_FIELD));
		fieldModel.squares = EMPTY;
		rotateCommand.execute();
		Assert.isTrue(compareArrays(fieldModel.elementsModel.currentChunk.field, ROTATED_ELEMENT_FIELD));
	}

	function clearModels():Void
	{
		var clearCommand = new ClearCommand();
		clearCommand.fieldModel = fieldModel;
		clearCommand.statsModel = statsModel;
		clearCommand.updateFieldSignal = cast signalPlaceholder;
		clearCommand.updateStatsSignal = cast signalPlaceholder;
		clearCommand.execute();
	}

	function compareArrays(a:Array<Array<Int>>, b:Array<Array<Int>>):Bool
	{
		var result:Bool = true;
		if (a == null || b == null) {
			result = false;
		} else {
			if (a.length != b.length) {
				result = false;
			} else {
				for (rowIndex in 0...a.length) {
					for (columnIndex in 0...a[rowIndex].length) {
						if (a[rowIndex][columnIndex] != b[rowIndex][columnIndex]) result = false;
					}
				}
			}
		}
		return result;
	}
}