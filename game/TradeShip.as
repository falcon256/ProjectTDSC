package game {	// just acts as an image
	import flash.display.MovieClip;
	public class TradeShip extends MovieClip {
		public var ship:Ship = new Ship();		
		public function TradeShip() {
			ship.isTrader=true;
			ship.myImage = this;
		}
	}
}
