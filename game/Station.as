
package game {	// just acts as an image
	import flash.display.MovieClip;
	public class Station extends MovieClip {
		public var ship:Ship = new Ship();		
		public function Station() {
			ship.isPirateStation=false;
			ship.isAlienStation=false;
			ship.isStation=true;
			ship.isCivilianStation = true;
			ship.myImage = this;
			ship.hull = 1000;
			ship.size = 110;
		}
	}
}
	
