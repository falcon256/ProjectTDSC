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
			//a.say("Attacking...");
			a.speed = 1;
			
			if(a.target.hull <=0||dist>1000)
			{
				a.setState(Agent.IDLE);
				//a.say("Killed!");
				//trace("Killed!");
			}
			
			var tr:Number = Math.atan2(dy, dx);
			a.targetRotation=tr;
			var dif = Math.abs(tr-a.myShip.rotation);
			if(dif<1)
				a.fireRailgun = true;
			else
				a.fireRailgun = false;
			if(a.myShip.hull <= 50)
			{
				a.setState(Agent.FLEE);
				
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
			//a.say("Attacking target at "+a.target.x+" "+a.target.y);
			a.speed = 0;
		}
		
		public function exit(a:Agent):void
		{
			
		}
		
	}

}