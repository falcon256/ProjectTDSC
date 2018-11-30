package game {	// just acts as an image
	import flash.display.MovieClip;
	public class PoliceShip extends MovieClip {
		public var ship:Ship = new Ship();		
		public function PoliceShip() {
			ship.isPolice=true;
			ship.myImage = this;
		}
	}
}
