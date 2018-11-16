package game {
	
	import flash.display.MovieClip;
	import agent.Agent;
	
	
	public class PlayerShip extends MovieClip {
		
		public var ship:Ship = new Ship();
		
		public function PlayerShip() {
						
		}
		
		public function doUpdate()
		{
			this.x=ship.x;
			this.y=ship.y;
			this.rotation = ship.rotation;
		}
		
	}
	
}
