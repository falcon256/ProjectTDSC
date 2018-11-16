
package game {
	import flash.display.MovieClip;
	import agent.Agent;
	
	public class Ship {

		public var myImage:MovieClip;
		public var myAgent:Agent;
		
		public var velx:Number;
		public var vely:Number;
		public var x:Number;
		public var y:Number;
		public var rotation:Number;
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
		}
		
		public function doUpdate()
		{
			this.velx+=myAgent.velocity.x;
			this.vely+=myAgent.velocity.y;
			this.x+=velx;
			this.y+=vely;
			
		}
	}
	
}
