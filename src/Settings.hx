package;

class Settings
{
	static inline var DEFAULT_FPS:Int = 30;

	public static var instance(get, null):Settings;

	public var fps:Int;

	function new()
	{
		init();
	}

	function init():Void
	{
		fps = DEFAULT_FPS;
	}

	static function get_instance():Settings
	{
		if (instance == null) instance = new Settings();
		return instance;
	}
}
