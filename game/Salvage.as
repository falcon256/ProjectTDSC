package  game{
	import flash.display.MovieClip;
	import agent.Agent;
	
	public class Salvage {
		public var myImage:MovieClip;
		public var myAgent:Agent;
		public var velx:Number=0;
		public var vely:Number=0;
		public var velDeltaX:Number=0;
		public var velDeltaY:Number=0;
		public var salv:Salvage = new Salvage();
		public function Salvage() {
			// constructor code
			this.x+=velx;
			this.y+=vely;
			velx*=0.999;
			vely*=0.999;
			myImage.x=this.x;
			myImage.y=this.y;
			myImage.rotation = this.rotation;
			testForCollisions();
			velDeltaX = Math.abs(lastVelX-this.velx);
			velDeltaY = Math.abs(lastVelY-this.vely);
			if(hull<0)
			{
				Main.getSingleton().removeShip(this);
			}
			
			
		}
		private function testForCollisions()
		{
			for each (var s in Main.getSingleton().getShipsList())
			{
				if(s!=this&&distance(s.x,s.y,this.x,this.y)<s.size+this.size)
				{					
					var vx:Number = s.velx - this.velx;
					var vy:Number = s.vely - this.vely;
					//trace("Collision - Velocity = " + vx + " " + vy);
					doCollision(this,s,vx,vy);
				}
			}
		}
		private function doCollision(s1:Ship, s2:Ship, vx:Number, vy:Number)
		{
			if(s1.isStation)
			{
				s2.velx-=vx*2;
				s2.vely-=vy*2;
				s2.x-=vx;
				s2.y-=vy;
			}
			else if(s2.isStation)
			{
				s1.velx+=vx*2;
				s1.vely+=vy*2;
				s1.x+=vx;
				s1.y+=vy;
			}
			else
			{
				s1.velx+=vx;
				s1.vely+=vy;
				s2.velx-=vx;
				s2.vely-=vy;
			}
		}

	}
	
}
