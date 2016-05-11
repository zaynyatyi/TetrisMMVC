package;

class Settings
{
	//Can also be mapped as singleton using mmvc injector class
	public static var instance(get, null):Settings;

	public var fps(default, null):Int;
	public var moveDelay(default, null):Int;

	public var fieldColumns(default, null):Int;
	public var fieldRows(default, null):Int;

	public var squareWidth(default, null):Int;
	public var squareHeight(default, null):Int;

	public var chunksCollection(default, null):Array<Chunk>;

	//Private constructor, so we can create instance of class just using static instance getter
	function new()
	{
		init();
	}

	function init():Void
	{
		fps = 30;
		//elements moving delay defined in design document
		moveDelay = 300;

		fieldColumns = 10;
		fieldRows = 20;

		squareWidth = 20;
		squareHeight = 20;

		//We are using compiletime macroses to parse our game objects from json file,
		chunksCollection = CompileTime.parseJsonFile("assets/chunks.json");
	}

	static function get_instance():Settings
	{
		if (instance == null) instance = new Settings();
		return instance;
	}
}

typedef Chunk = {
	field:Array<Array<Int>>
}