package game { // just acts as an image
	import flash.display.MovieClip;
	public class PlayerShip extends MovieClip {		
		public var ship:Ship = new Ship();
		public function PlayerShip() {
			ship.isPlayer=true;
			ship.myImage = this;
		}
	}
}
