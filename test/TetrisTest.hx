package;

import massive.munit.Assert;
import msignal.Signal.Signal0;
import tetris.commands.ClearCommand;
import tetris.commands.ExtrudeCommand;
import tetris.models.ElementsModel;
import tetris.models.FieldModel;
import tetris.models.StateModel;
import tetris.models.StatsModel;
import tetris.utils.RegularElementsCreator;

class TetrisTest
{
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

	function clearModels():Void
	{
		var clearCommand = new ClearCommand();
		clearCommand.fieldModel = fieldModel;
		clearCommand.statsModel = statsModel;
		clearCommand.updateFieldSignal = cast signalPlaceholder;
		clearCommand.updateStatsSignal = cast signalPlaceholder;
		clearCommand.execute();
	}
}