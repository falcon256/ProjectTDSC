package game {
	
	import flash.display.MovieClip;
	
	
	public class MovingBackground extends MovieClip {
		
		public var xoff:Number = 0;
		public var yoff:Number = 0;
		public function MovingBackground() {
			// constructor code
		}
		
		public function update(xo:Number, yo:Number)
		{
			xoff = xo;
			yoff = yo;
			this.layer1.x=xoff*0.02;
			this.layer1.y=yoff*0.02;
			//this.layer2.x=xoff*0.04;
			//this.layer2.y=yoff*0.04;
			//this.layer3.x=xoff*0.08;
			//this.layer3.y=yoff*0.08;
		}
	}
	
}
