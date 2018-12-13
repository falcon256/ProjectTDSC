package agent.states 
{
	import agent.Agent;
	public class IdleState implements IAgentState
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:Agent):void
		{
			for each (var pew in Main.getSingleton().getShipsList())
			{
				
				var dist:Number = Main.distance(a.myShip.x, a.myShip.y, pew.x, pew.y);
				
				if (a.myShip.isPirate&&dist<1000) {
					if(!pew.isPirate)
					{
						a.target = pew;
						a.setState(Agent.ATTACK);
					}
				}
			}
			
			if(a.myShip.isTrader)
			{
				//var ships:Vector.<Ship> = Main.getSingleton().getShipsList();
				//var options:Vector.<Ship> = new Vector.<Ship>();
				//find another space station to move to.
				//for( int i = 0 ; i < ships.
			}
			
			
		}
		
		public function enter(a:Agent):void
		{
			a.say("Idling...");
			a.speed = 0;
		}
		
		public function exit(a:Agent):void
		{
			a.randomDirection();
		}
		
	}

}