package game { // just acts as an image
	import flash.display.MovieClip;
	import flash.events.Event;
	import game.Debris;
	import game.DebrisObject;
	
	public class PlayerShip extends MovieClip {		
		public var ship:Ship = new Ship();
		public function PlayerShip() {
			ship.isPlayer=true;
			ship.myImage = this;
			addEventListener(Event.ENTER_FRAME, update);
			
		}
		
		public function update(evt:Event)
		{
			if(Main.getSingleton()!=null&&Main.getSingleton().debrises!=null)
			{
				for each(var d in Main.getSingleton().getDebrisList())
				{
					if(Main.distance(d.x,d.y,this.x,this.y)<200)
					{			
						var dx:Number = this.x - d.x;
						var dy:Number = this.y - d.y;
						var targetrotation:Number = Ship.degrees(Math.atan2(dy, dx));
						Arm1.rotation = targetrotation-this.rotation + 180;
						trace(Arm1);
					}
				}
			}
		}
	}
}
