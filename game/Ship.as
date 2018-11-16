
package game {
	import flash.display.MovieClip;
	import agent.Agent;
	
	public class Ship {

		public var myImage:MovieClip;
		public var myAgent:Agent;
		
		public var velx:Number=0;
		public var vely:Number=0;
		public var x:Number=0;
		public var y:Number=0;
		public var rotation:Number=0;
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
		
		public function Ship()
		{
			myAgent = new Agent();
			this.x=0;
			this.y=0;
		}
		
		public function doUpdate()
		{
			if(!isPlayer)
			{
				myAgent.update();
				this.velx+=myAgent.velocity.x*0.001;
				this.vely+=myAgent.velocity.y*0.001;
				myAgent.x=this.x;
				myAgent.y=this.y;
				this.rotation += degrees(Math.atan2(vely,velx)) * 0.1;
				this.rotation -= this.rotation * 0.1;
			}
			
			this.x+=velx;
			this.y+=vely;
			//this.rotation+= myAgent.rotation*0.01;
			//this.rotation-= 0.01;
			trace("Ship Update " + this.x + " " + this.y);
			myImage.x=this.x;
			myImage.y=this.y;
			myImage.rotation = this.rotation;
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
		
	}
	
}
