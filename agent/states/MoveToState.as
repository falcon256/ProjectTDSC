package agent.states 
{
	import agent.Agent;
	public class MoveToState implements IAgentState
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:Agent):void
		{
			var dx:Number =  a.targetX - a.x;
			var dy:Number =  a.targetY - a.y;
			var dist:Number = Agent.distance1(dx,dy);
			a.velocity.x = (dx/dist)*a.speed;
			a.velocity.y = (dy/dist)*a.speed;
			a.say("Moving...");
			a.speed = 2;
			
			if(Agent.distance1(dx,dy) < 1)
			{
				a.setState(Agent.IDLE);
				a.say("Arrived!");
				trace("Arrived!");
			}
			var tr:Number = Math.atan2(dy, dx);
			
			a.targetRotation=tr;
			//debug output
			//trace("Moving, distance is: "+Agent.distance1(dx,dy));
		}
		
		public function enter(a:Agent):void
		{
			var dx:Number =  a.targetX - a.x;
			var dy:Number =  a.targetY - a.y;
			var dist:Number = Agent.distance1(dx,dy);
			a.velocity.x = (dx/dist)*a.speed;
			a.velocity.y = (dy/dist)*a.speed;
			a.say("Moving to coords "+a.targetX+" "+a.targetY);
			a.speed = 0;
		}
		
		public function exit(a:Agent):void
		{
			
		}
		
	}

}