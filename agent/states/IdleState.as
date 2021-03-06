﻿package agent.states 
{
	import agent.Agent;
	public class IdleState implements IAgentState
	{
		
		/* INTERFACE agent.states.IAgentState */
		
		public function update(a:Agent):void
		{
			var dx:Number =  a.target.x - a.x;
			var dy:Number =  a.target.y - a.y;
			var dista:Number = Agent.distance1(dx,dy);
			a.velocity.x = (dx/dista)*a.speed;
			a.velocity.y = (dy/dista)*a.speed;
			a.speed = 0.5;
			
			for each (var pew in Main.getSingleton().getShipsList())
			{
				
				if(pew==Main.getSingleton().playerS.ship)
				{
					if(Main.getSingleton().Reputation<-10)
					{
						if(a.myShip.isPolice)
						{
							a.target = pew;
							a.setState(Agent.ATTACK);
						}
					}
					else if(Main.getSingleton().Reputation>10)
					{
						if(a.myShip.isPirate)
						{
							a.target = pew;
							a.setState(Agent.ATTACK);
						}
					}
				}
				var dist:Number = Main.distance(a.myShip.x, a.myShip.y, pew.x, pew.y);
				
				if (a.myShip.isPirate&&dist<1000) {
					if(!pew.isPirate && !pew.isPirateStation)
					{
						a.target = pew;
						a.setState(Agent.ATTACK);
					}
				}
				
				if (a.myShip.isAlien&&dist<1000) {
					if(!pew.isAlien && !pew.isAlienStation)
					{
						a.target = pew;
						a.setState(Agent.ATTACK);
					}
				}
				
				if (a.myShip.isPolice&&dist<1000) {
					if(!pew.isPolice && !pew.isTrader && !pew.isCivilianStation)
					{
						a.target = pew;
						a.setState(Agent.ATTACK);
					}
				}
				/*if(a.myShip.isTrader && dist < 1000)
				{
				
				}*/
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