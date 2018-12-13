
package game {	// just acts as an image
	import flash.display.MovieClip;
	public class PirateStation extends MovieClip {
		public var ship:Ship = new Ship();		
		public function PirateStation() {
			ship.isPirateStation=true;
			ship.isAlienStation=false;
			ship.isStation= true;
			ship.isCivilianStation = false;
			ship.myImage = this;
			
			ship.hull = 1000;
			ship.size = 140;
		}
	}
}