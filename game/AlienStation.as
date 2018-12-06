
package game {	// just acts as an image
	import flash.display.MovieClip;
	public class AlienStation extends MovieClip {
		public var ship:Ship = new Ship();		
		public function AlienStation() {
			ship.isAlienStation=true;
			ship.isStation=true;
			ship.myImage = this;
			ship.size = 110;
		}
	}
}
