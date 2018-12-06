package game {
	import flash.display.MovieClip;
	import flash.events.Event;

	public class RailgunRound extends MovieClip{

		public var velx:Number=0;
		public var vely:Number=0;
		public var velRot:Number=0;
		public var lifetime:Number=1;
		public var size:Number=1;
		public var sizeDelta:Number=0;
		public var alphaDelta:Number=0;
		public var parentShip:Ship = null;
		public var active:Boolean = true;
		public function RailgunRound(s:Ship) {
			parentShip=s;
			addEventListener(Event.ENTER_FRAME, update);
		}

		
		public function update(evt:Event)
		{
			if(active)
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
				testForCollisions();
			}
		}
		
		public static function distance(x1:Number,y1:Number,x2:Number,y2:Number):Number
		{
			return Math.sqrt(((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2)));
		}
		
		private function testForCollisions()
		{
			for each (var s in Main.getSingleton().getShipsList())
			{
				if(s!=this.parentShip&&distance(s.x,s.y,this.x,this.y)<s.size)
				{					
					var vx:Number = s.velx - this.velx;
					var vy:Number = s.vely - this.vely;
					trace("Railgun hit! - Velocity = " + vx + " " + vy +" Enemy Health: " + s.hull);
					var velocityMag:Number = Math.sqrt((vx*vx)+(vy*vy));
					s.hull-=velocityMag;
					active=false;
					if(this.parent)
						this.parent.removeChild(this);
				}
			}
		}
		
		
	}
	
}
