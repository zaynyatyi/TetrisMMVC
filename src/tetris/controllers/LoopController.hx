package tetris.controllers;

import haxe.Timer;
import mmvc.impl.Actor;

class LoopController extends Actor
{
	var loopTimer:Timer;

	public function new()
	{
		super();
		loopTimer = new Timer(1000 / Settings.instance.fps);
		loopTimer.run = loop;
	}

	function loop():Void
	{
	}
}
