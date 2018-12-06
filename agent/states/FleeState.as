package agent.states 
{

	/**
	 * ...
	 * @author Andreas Rønning
	 */
import agent.Agent;
	public class FleeState implements IAgentState
	{
		
		/* INTERFACE agent.states.IAgentState */
		//////////////////////////////////////////////TODOTODOTODOTODO
		public function update(a:Agent):void
		{
			var dx:Number =  a.target.x - a.x;
			var dy:Number =  a.target.y - a.y;
			var dist:Number = Agent.distance1(dx,dy);
			a.velocity.x = -(dx/dist)*a.speed;
			a.velocity.y = -(dy/dist)*a.speed;
			a.say("Fleeing...");
			a.speed = 1;
			
			if(a.target.hull <=0)
			{
				a.setState(Agent.IDLE);
				a.say("Killed!");
				trace("Killed!");
			}
			
			var tr:Number = Math.atan2(dy, dx);
			var dif = Math.abs(tr-a.myShip.rotation);
			if(dif<1)
				a.fireRailgun = true;
			else
				a.fireRailgun = false;
			
			//debug output
			//trace("Attacking, distance is: "+Agent.distance1(dx,dy));
		}
		
		public function enter(a:Agent):void
		{
			var dx:Number =  (a.target.x - a.x);
			var dy:Number =  (a.target.y - a.y);
			var dist:Number = Agent.distance1(dx,dy);
			a.velocity.x = -(dx/dist)*a.speed;
			a.velocity.y = -(dy/dist)*a.speed;
			a.say("Flee "+a.target.x+" "+a.target.y);
			a.speed = 0;
		}
		
		public function exit(a:Agent):void
		{
			
		}
		
	}

}
	
