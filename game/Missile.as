package game {
	import game.Ship;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Missile extends MovieClip{

		public var velx:Number=0;
		public var vely:Number=0;
		public var velRot:Number=0;
		public var lifetime:Number=1;
		public var size:Number=1;
		public var sizeDelta:Number=0;
		public var alphaDelta:Number=0;
		public var parentShip:Ship = null;
		public var active:Boolean = true;
		public var fuel:Number = 1000;
		public var targetX:Number;
		public var targetY:Number;
		
		public var targetShip:Ship;
		
		public var pid:PID;
		
		public function Missile(s:Ship) {
			parentShip=s;
			addEventListener(Event.ENTER_FRAME, update);
			pid = new PID(0.02,0.0001,0.0001);
			
		}

		
		public function update(evt:Event)
		{
			if(active)
			{
				this.x+=velx;
				this.y+=vely;
				this.rotation+=velRot;
				velRot*=0.99;
				
				if(targetShip!=null&&targetShip.myImage.parent!=null)
				{
					targetX = targetShip.x;
					targetY = targetShip.y;

				}
				if(targetShip!=null&&targetShip.myImage.parent==null)
				{
					targetShip=null;
				}				
				
				//guidance code
				if(!isNaN(targetX)&&!isNaN(targetY)&&fuel>0)
				{
					var dx:Number = targetX - x;
					var dy:Number = targetY - y;
					var targetrotation:Number = Ship.degrees(Math.atan2(dy, dx));
					var TargRot: Number =(180/Math.PI)*Math.atan2((Math.cos(this.rotation*Math.PI/180)*Math.sin(targetrotation*Math.PI/180)-Math.sin(this.rotation*Math.PI/180)*Math.cos(targetrotation*Math.PI/180)),(Math.sin(this.rotation*Math.PI/180)*Math.sin(targetrotation*Math.PI/180)+Math.cos(this.rotation*Math.PI/180)*Math.cos(targetrotation*Math.PI/180)));
					var rot:Number = pid.tick(TargRot);
					//var rot = TargRot;
					
					//trace(rot);
					velRot+=rot*0.5;
					
					
					
					velx += Math.cos(Ship.radians(this.rotation))*0.1;
					vely += Math.sin(Ship.radians(this.rotation))*0.1;
					fuel--;
					
					
				}
				
				if(fuel<0)
				{
					lifetime-=1;
				}
					//detection code
					if(targetShip==null)
					{
						for each (var s in Main.getSingleton().getShipsList())
						{
							if(s!=this.parentShip&&distance(s.x,s.y,this.x,this.y)<500)
							{					
								targetShip=s;
								targetX = s.x;
								targetY = s.y;
								trace("New missile target detected");
								
							}
						}
					}
				
				
				//size-=sizeDelta;
				//alpha-=alphaDelta;
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
					//trace("Railgun hit! - Velocity = " + vx + " " + vy +" Enemy Health: " + s.hull);
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
