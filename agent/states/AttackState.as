package agent.states 
{
	import agent.Agent;
	public class AttackState implements IAgentState
	{
		
		/* INTERFACE agent.states.IAgentState */
		//////////////////////////////////////////////TODOTODOTODOTODO
		public function update(a:Agent):void
		{
			var dx:Number =  a.target.x - a.x;
			var dy:Number =  a.target.y - a.y;
			var dist:Number = Agent.distance1(dx,dy);
			a.velocity.x = (dx/dist)*a.speed;
			a.velocity.y = (dy/dist)*a.speed;
			a.say("Attacking...");
			a.speed = 2;
			
			if(a.target.hull <=0)
			{
				a.setState(Agent.IDLE);
				a.say("Killed!");
				trace("Killed!");
			}
			
			//debug output
			//trace("Attacking, distance is: "+Agent.distance1(dx,dy));
		}
		
		public function enter(a:Agent):void
		{
			var dx:Number =  a.target.x - a.x;
			var dy:Number =  a.target.y - a.y;
			var dist:Number = Agent.distance1(dx,dy);
			a.velocity.x = (dx/dist)*a.speed;
			a.velocity.y = (dy/dist)*a.speed;
			a.say("Attacking target at "+a.target.x+" "+a.target.y);
			a.speed = 0;
		}
		
		public function exit(a:Agent):void
		{
			
		}
		
	}

}