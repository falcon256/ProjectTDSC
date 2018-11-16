package game {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.ui.Mouse;
	
	public class BaseGameGUI extends MovieClip {
		
		
		public function BaseGameGUI() {
			addEventListener(Event.ENTER_FRAME,tempCashUpdate);
			Mouse.hide();
		}
		
		//todo move this into main game loop, when it is created.
		private var rep:Number = 1;
		private var cash:Number = 1;
		private var ticksSinceUpdate:int = 1440;
		private function tempCashUpdate(e:Event)
		{
			ticksSinceUpdate++;
			if(ticksSinceUpdate>GameParameters.TICKS_PER_INCOME)
			{
				ticksSinceUpdate=0;
				cash+=Math.max(0,rep);//don't lose cash for being an asshole.
				text_Rep.text = "Reputation: "+rep;
				text_Cash.text = "Cash: "+cash;
			}
			Main.targetingCursor.x = mouseX;//(mouseX+Main.sGameMap.x);
			Main.targetingCursor.y = mouseY;//(mouseY+Main.sGameMap.y);
		}
	}
	
}
