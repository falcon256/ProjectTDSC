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
		public var isDebris:Boolean = true;
		public var x:Number=0;
		public var y:Number=0;
		public var hull:Number=100;
		public function Salvage() {
			// constructor code
			var lastVelX:Number = this.velx;
			var lastVelY:Number = this.vely;
			this.x+=velx;
			this.y+=vely;
			velx*=0.999;
			vely*=0.999;
			myImage.x=this.x;
			myImage.y=this.y;
			/*myImage.rotation = this.rotation;*/
			
			velDeltaX = Math.abs(lastVelX-this.velx);
			velDeltaY = Math.abs(lastVelY-this.vely);
			if(hull<0)
			{
				trace("Hi");
			}
			
			
		}
	
	

	}
	
}
