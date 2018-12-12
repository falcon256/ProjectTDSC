package agent.states 
{
	//Ross
	import Main;
	import agent.Agent;
	import game.PirateShip;
	
	public class BuildShipState implements IAgentState
	{
			public var count:int = 0;
			public var limit:int = 1440;
			public var increase:int = 1;
		
	public function update(a:Agent):void
		{
			a.velocity.x*=0.5;
			a.velocity.y*=0.5;
			a.speed = 0;
			
			
			if (count <= limit)
				{
					count += increase;
					
				}
				else
				{
					count = 0;
					
					var pirateS:PirateShip = new PirateShip();
					Main.getSingleton().gameMap.addChild(pirateS);
					
					Main.getSingleton().ships.push(pirateS.ship);
					Main.getSingleton().gameMap.addChild(pirateS.ship.myAgent);
					Main.getSingleton().agents.push(pirateS.ship.myAgent);

					pirateS.ship.myAgent.targetX=500;
					pirateS.ship.myAgent.targetY=500;
					pirateS.ship.myAgent.target=Main.getSingleton().playerS.ship;
					pirateS.ship.myAgent.setState(Agent.ATTACK);
					
					var x1:Number = a.myShip.x;
					var y1:Number = a.myShip.y;
					for each (var s in Main.getSingleton().getShipsList())
					{
						if(s.isPirateStation&&Math.random()>0.95)
						{
							x1 = s.x;
							y1 = s.y;
						}
					}
					
					
					
					pirateS.ship.x = x1 + (Math.random() - Math.random()) * 100;
					pirateS.ship.y = y1 + (Math.random() - Math.random()) * 100;
				}	
			
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
/*var pirateS:PirateShip = new PirateShip();
gameMap.addChild(pirateS);
*/