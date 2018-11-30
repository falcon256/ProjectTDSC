package game {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import agent.Agent;
	
	
	public class Station {
		
		public var station:Station = new Station();
		private var GrabShip:MovieClip;

		public function Station() {
			addChild(station); 
			
		}
		
		private function dockship(event:Event):void {
			if (( Math.abs( ship.x-station.x) < 20)&&
			(Math.abs( ship.y-station.y) < 20))
			{
				
			
			addChild(GrabShip)
			GrabShip.x = station.x + 5;
			GrabShip.y = station.y + 5;
				}
			
			GrabShip.addEventListener(MouseEvent.CLICK, openmenu);//change to keyboard event we use mouse to fire
				
			}
			
		private function openmenu(event:Event):void {
			
			removeEventListener(MouseEvent.CLICK, openmenu);
			addChild(salvagescreen);
			
			}
		
		}

	}
	
