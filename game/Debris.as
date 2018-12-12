package  game{
	
	import flash.display.MovieClip;
	public class Debris extends MovieClip {
		/*public var salv:Salvage = new Salvage();*/		
		public function Debris() {
		/*	salv.isDebris = true;*/
			 this.gotoAndStop(Math.ceil(Math.random()*5));
			
			
			
		}

	}
	
}
