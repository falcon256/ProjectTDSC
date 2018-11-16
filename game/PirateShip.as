package game {	// just acts as an image
	import flash.display.MovieClip;
	public class PirateShip extends MovieClip {
		public var ship:Ship = new Ship();		
		public function PirateShip() {
			ship.isPirate=true;
			ship.myImage = this;
		}
	}
}
