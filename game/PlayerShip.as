package game { // just acts as an image
	import flash.display.MovieClip;
	import flash.events.Event;
	import game.Debris;
	import game.DebrisObject;
	
	public class PlayerShip extends MovieClip {		
		public var ship:Ship = new Ship();
		public var collecting:Boolean = false;
		public var colN:Number = 0;
		
		public function PlayerShip() {
			ship.isPlayer=true;
			ship.myImage = this;
			ship.hull=100;
			addEventListener(Event.ENTER_FRAME, update);
			
		}
		
		public function update(evt:Event)
		{
			
			var found:Boolean = false;
			if(Main.getSingleton()!=null&&Main.getSingleton().debrises!=null)
			{
				for each(var d in Main.getSingleton().getDebrisList())
				{
					var dist:Number = Main.distance(d.x,d.y,this.x,this.y)
					if(dist<200)
					{			
						found=true;
						
						var dx:Number = d.x - this.x;
						var dy:Number = d.y - this.y;
						var targetrotation:Number = Ship.degrees(Math.atan2(dy, dx));
						
						var rot:Number = Math.max(Math.min(90,90-dist),0);
						
						Arm1.rotation = (targetrotation + rot) - ship.rotation;
						Arm2.rotation = (targetrotation - rot) - ship.rotation;
						//Arm1.rotation = targetrotation-this.rotation + 180;
						
						Arm2.x = Math.cos(Ship.radians(Arm1.rotation))*40;
						Arm2.y = Math.sin(Ship.radians(Arm1.rotation))*40;
						
						var tx:Number = ship.x + Math.cos(Ship.radians(ship.rotation))*80;
						var ty:Number = ship.y + Math.sin(Ship.radians(ship.rotation))*80;
						
						if(dist<100)
						{
							d.debrisClip.x-=dx*0.01;
							d.debrisClip.y-=dy*0.01;
							d.x=d.debrisClip.x;
							d.y=d.debrisClip.y;
						}
						
						
						
						if(Main.distance(this.x,this.y,d.x,d.y)<5)
						{
							collecting=true;
						}
						if(collecting)
						{							
							
							
							/*
							d.debrisClip.x = d.x = ship.x + Math.cos(Ship.radians(ship.rotation+Arm1.rotation))*(80 - (colN/2));
							d.debrisClip.y = d.y = ship.y + Math.sin(Ship.radians(ship.rotation+Arm1.rotation))*(80 - (colN/2));
							
							
							
							Arm1.rotation = colN+targetrotation-this.rotation + 180;
							Arm2.rotation = -colN/2.4;
							Arm2.x = Math.cos(Ship.radians(Arm1.rotation))*40;
							Arm2.y = Math.sin(Ship.radians(Arm1.rotation))*40;
							tx = ship.x + Math.cos(Ship.radians(ship.rotation))*80;
							ty = ship.y + Math.sin(Ship.radians(ship.rotation))*80;
							
							if(colN<120)
								colN++;
							if(Math.random()>0.9&&colN>110)
							{*/
								d.debrisClip.parent.removeChild(d.debrisClip);
								Main.getSingleton().removeDebris(d);
								collecting=false;
								colN=0;
								Main.getSingleton().Cash++;
								Main.getSingleton().gameScore.text = "Reputation: "+Main.getSingleton().Reputation+" Cash: "+Main.getSingleton().Cash;
								if(ship.hull<200)
									ship.hull+=Math.random()*100;
							//}
						}
						
						
						
						
						
						
						
						
						
						
						//trace(Arm1);
					}
				}
			}
			if(!found)
			{
				Arm1.visible=false;
				Arm2.visible=false;
			}
			else
			{
				Arm1.visible=true;
				Arm2.visible=true;
			}
		}
	}
}
