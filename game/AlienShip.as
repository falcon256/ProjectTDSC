package game {	// just acts as an image
	import flash.display.MovieClip;
	public class AlienShip extends MovieClip {
		public var ship:Ship = new Ship();		
		public function AlienShip() {
			ship.isAlien=true;
			ship.myImage = this;
		}
	}
}
