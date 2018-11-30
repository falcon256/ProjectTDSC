package game {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Particle extends MovieClip{

		public velx:Number=0;
		public vely:Number=0;
		public velRot:Number=0;
		public lifetime:Number=1;
		public size:Number=1;
		public sizeDelta:Number=0;
		public alphaDelta:Number=0;
		
		public function Particle() {
			addEventListener(Event.ENTER_FRAME, update);
		}

		
		public function update(evt:Event)
		{
			this.x+=velx;
			this.y+=vely;
			this.rotation+=velRot;
			lifetime-=1;
			size-=sizeDelta;
			alpha-=alphaDelta;
			if(size<0)
				size=0;
			if(alpha<0)
				alpha=0;
			this.scaleX=size;
			this.scaleY=size;
		}
	}
	
}
