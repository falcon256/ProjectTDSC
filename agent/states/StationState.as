package agent.states 
{
	import agent.Agent;
	public class StationState implements IAgentState
	{
		
	public function update(a:Agent):void
		{
			a.velocity.x*=0.5;
			a.velocity.y*=0.5;
			a.speed = 0;
			
		}
		
		public function enter(a:Agent):void
		{

			a.velocity.x*=0.5;
			a.velocity.y*=0.5;
			a.speed = 0;
		}
		
		public function exit(a:Agent):void
		{
			
		}
		
	}

}