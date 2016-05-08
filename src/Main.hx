package;

import app.ApplicationContext;
import app.ApplicationView;

class Main
{
	static function main()
	{
		var applicationView:ApplicationView = new ApplicationView();
		var applicationContext:ApplicationContext = new ApplicationContext(applicationView);
	}
}