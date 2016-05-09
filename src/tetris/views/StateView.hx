package tetris.views;

import core.DataView;
import tetris.models.StateModel;

/*
 * Game state view. It will request frame update, show game over message.
 */
class StateView extends DataView<StateModel>
{
	public function new(?data:StateModel)
	{
		super(data);
	}
}
