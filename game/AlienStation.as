
package game {	// just acts as an image
	import flash.display.MovieClip;
	public class AlienStation extends MovieClip {
		public var ship:Ship = new Ship();		
		public function AlienStation() {
			ship.isPirateStation=false;
			ship.isAlienStation=true;
			ship.isStation=true;
			ship.isCivilianStation = false;
			ship.myImage = this;
			ship.hull = 1000;
			ship.size = 100;
		}
	}
}
