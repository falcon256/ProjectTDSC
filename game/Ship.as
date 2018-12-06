
package game {
	import flash.display.MovieClip;
	import agent.Agent;
	
	public class Ship {

		public var myImage:MovieClip;
		public var myAgent:Agent;
		
		public var velx:Number=0;
		public var vely:Number=0;
		public var velrot:Number=0;
		public var x:Number=0;
		public var y:Number=0;
		public var rotation:Number=0;
		public var size:Number = 20;
		
		//basic ship stats
		public var maxHull:Number=100;
		public var hull:Number=100;
		public var maxShield:Number=100;
		public var shield:Number=100;
		public var maxMissiles:Number=10;
		public var missiles:Number=10;
		public var maxFlares:Number=100;
		public var flares:Number=100;
		
		//upgrade stats
		public var upgArmor:int=1;//reduces hull damage taken
		public var upgShield:int=1;//increases charge rate and max hp of shield
		public var upgRailgun:int=1;//increases bullet lifetime and velocity
		public var upgLaser:int=1;//increases falloff distance
		public var upgMissile:int=1;//increases missile count, rotation, damage, and fuel
		public var upgRCS:int=1;//speeds up ship rotation
		public var upgEngine:int=1;//speeds up ship acceleration
		public var upgFlares:int=1;//ejection speed, effectiveness, and number of flares
		public var upgEMReduction:int=1;//lowers shield and active sensor emissions
		public var upgThermalReduction:int=1;//lowers engine and rcs emissions
		public var upgSensors:int =1;//detects ships, stations, and missiles and presents an indicator for them. 
		
		//as3 doesn't have enumerations, so...
		public var isPlayer:Boolean=false;
		public var isTrader:Boolean=false;
		public var isNavy:Boolean=false;
		public var isPolice:Boolean=false;
		public var isAlien:Boolean=false;
		public var isPirate:Boolean=false;
		public var isStation:Boolean = false;
		
		public var velDeltaX:Number=0;
		public var velDeltaY:Number=0;
		
		public var railgunTimer:Number = 0;
		public var laserTimer:Number = 0;
		public var missileTimer:Number = 0;
		
		public function Ship()
		{
			myAgent = new Agent();
			myAgent.myShip = this;
			this.x=0;
			this.y=0;
		}
		
		public function doUpdate()
		{
			var lastVelX:Number = this.velx;
			var lastVelY:Number = this.vely;
			var sm:Particle = new Particle();
			this.myImage.parent.addChild(sm);
			sm.lifetime=(velDeltaX+velDeltaY)*20;
			sm.alpha=(velDeltaX+velDeltaY)*2;
			sm.sizeDelta=0.01;
			sm.alphaDelta=0.01;
			sm.x=this.x-this.myImage.width/2;
			sm.y=this.y-this.myImage.height/2;
			
			if(railgunTimer>0)
				railgunTimer--;
			if(laserTimer>0)
				laserTimer--;
			if(missileTimer>0)
				laserTimer--;
			
			if(!isPlayer)
			{
				myAgent.update();
				
				this.velx+=myAgent.velocity.x*0.05;
				this.vely+=myAgent.velocity.y*0.05;
				myAgent.x=this.x;
				myAgent.y=this.y;
				
				//WOW
				var targetrotation = myAgent.targetRotation;
				//var targetrotation:Number = degrees(Math.atan2(vely,velx));
				this.rotation+=(180/Math.PI)*Math.atan2((Math.cos(this.rotation*Math.PI/180)*Math.sin(targetrotation*Math.PI/180)-Math.sin(this.rotation*Math.PI/180)*Math.cos(targetrotation*Math.PI/180)),(Math.sin(this.rotation*Math.PI/180)*Math.sin(targetrotation*Math.PI/180)+Math.cos(this.rotation*Math.PI/180)*Math.cos(targetrotation*Math.PI/180)))/20;
				
				
				
				//this.rotation = degrees(Math.atan2(vely,velx));
				/*
				this.rotation += degrees(Math.atan2(vely,velx)) * 0.5;
				this.rotation -= this.rotation * 0.1;
				if(this.rotation>360)
					this.rotation-=360;
				if(this.rotation<0)
					this.rotation+=360;*/
				
				if(myAgent.fireRailgun)
					this.fireRailgun();
				
			}
			
			//this.velx+= -this.x*0.001;
			//this.vely+= -this.y*0.001;
			
			
			this.x+=velx;
			this.y+=vely;
			velx*=0.999;
			vely*=0.999;
			//this.rotation+= myAgent.rotation*0.01;
			//this.rotation-= 0.01;
			//trace("Ship Update " + this.x + " " + this.y);
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
					trace("Collision - Velocity = " + vx + " " + vy);
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
		
		public static function distance(x1:Number,y1:Number,x2:Number,y2:Number):Number
		{
			return Math.sqrt(((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2)));
		}
		
		//stolen and generic
		public static function degrees(radians:Number):Number
		{
			return radians * 180/Math.PI;
		}
		//stolen and generic 
		public static function radians(degrees:Number):Number
		{
			return degrees * Math.PI / 180;
		}		
		
		public function fireRailgun()
		{
			if(railgunTimer<=0)
			{
				railgunTimer+=10;
				var pew:RailgunRound = new RailgunRound(this);
				trace("pew");
				this.myImage.parent.addChild(pew);
				pew.rotation = this.myImage.rotation;
				trace(pew.velx + " " + this.velx + " " + Math.cos(Ship.radians(this.rotation)));
				
				pew.velx = this.velx + Math.cos(Ship.radians(this.rotation))*20;
				pew.vely = this.vely + Math.sin(Ship.radians(this.rotation))*20;
				pew.lifetime=100;
				pew.sizeDelta=0.01;
				pew.alphaDelta=0.01;
				pew.x=this.x;
				pew.y=this.y;
				
				//not sure where this nan is coming from, but lets stomp it out here.
				if(isNaN(pew.velx))
				{
					pew.lifetime=0;
					pew.velx=0;
				}
				if(isNaN(pew.vely))
				{
					pew.lifetime=0;
					pew.vely=0;
				}
			}
		}
				
		
	}
	
}
