package game {
	
	import Main;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import agent.Agent;
	
	
	public class Station {
		
		public var station:Station = new Station();
		private var GrabShip:MovieClip;
		public var dockBtn

		public function Station() {
			addChild(station); 
			if (playerS.ship.x = 100){
				
			
		/*	if (( Math.abs( playerS.ship.x-station.x) < 50)&&
			(Math.abs( playerS.ship.y-station.y) < 50))*/
			
				trace("Hi");
				dockship();
			/*addChild(GrabShip)
			GrabShip.x = station.x + 5;
			GrabShip.y = station.y + 5;*/
				}
			
		}
		
		private function dockship(event:Event):void {
			
			trace("Hi");
			addChildAt(dockBtn,playerS.ship.x - 20, playerS.ship.y - 20);
			GrabShip.addEventListener(MouseEvent.CLICK, openmenu);//change to keyboard event we use mouse to fire
				
			}
			
		private function openmenu(event:Event):void {
			
			removeEventListener(MouseEvent.CLICK, openmenu);
			addChild(salvagescreen);
			
			}
		
		}

	}
	
