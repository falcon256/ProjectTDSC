package game {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class Particle extends MovieClip{

		public var velx:Number=0;
		public var vely:Number=0;
		public var velRot:Number=0;
		public var lifetime:Number=1;
		public var size:Number=1;
		public var sizeDelta:Number=0;
		public var alphaDelta:Number=0;
		
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
			
			if(lifetime<0&&this.parent!=null)
				this.parent.removeChild(this);
		}
	}
	
}
