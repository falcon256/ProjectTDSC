package agent.states 
{
	//Ross
	import Main;
	import agent.Agent;
	import game.PirateShip;
	import game.PoliceShip;
	import game.AlienShip;
	import game.Ship;
	
	public class BuildShipState implements IAgentState
	{
			public var count:int = 0;
			public var limit:int = 100;
			public var increase:int = 1;
			
	public function update(a:Agent):void
		{
			a.velocity.x*=0.5;
			a.velocity.y*=0.5;
			a.speed = 0;
			var x1:Number = a.myShip.x;
			var y1:Number = a.myShip.y;
			
			for each (var pew in Main.getSingleton().getShipsList())
			{
				var dist:Number = Main.distance(a.myShip.x, a.myShip.y, pew.x, pew.y);
				if(dist<350)
				{
				if (a.myShip.isPirateStation) {
					if(!pew.isPirate&&!pew.isPirateStation)
					{
						a.myShip.fireMissile();
					}
				}
				if (a.myShip.isStation) {
					if(!pew.isPolice&&!pew.isStation){
						a.myShip.fireMissile();
					}
				}
				if (a.myShip.isAlienStation) {
					if(!pew.isAlien&&!pew.isAlienStation){
						a.myShip.fireMissile();
					}
				}
			}
			}
			
			
			
			
			if (count <= limit)
				{
					count += increase;
					//trace(count);
				}
				else
				{
					count = 0;
					if (a.myShip.isPirateStation) {
						var pirateS:PirateShip = new PirateShip();
						Main.getSingleton().gameMap.addChild(pirateS);
						
						Main.getSingleton().ships.push(pirateS.ship);
						Main.getSingleton().gameMap.addChild(pirateS.ship.myAgent);
						Main.getSingleton().agents.push(pirateS.ship.myAgent);

						pirateS.ship.myAgent.targetX=500;
						pirateS.ship.myAgent.targetY=500;
						pirateS.ship.myAgent.target=Main.getSingleton().playerS.ship;
						pirateS.ship.myAgent.setState(Agent.ATTACK);
						
						
						for each (var s1 in Main.getSingleton().getShipsList())
						{
							if(s1.isPirateStation&&Math.random()>0.9)
							{
								x1 = s1.x;
								y1 = s1.y;
							}
						}
						pirateS.ship.x = x1 + (Math.random() - Math.random()) * 200;
						pirateS.ship.y = y1 + (Math.random() - Math.random()) * 200;
					}
					
					if(a.myShip.isCivilianStation) {
						var policeS:PoliceShip = new PoliceShip();
						Main.getSingleton().gameMap.addChild(policeS);
						
						Main.getSingleton().ships.push(policeS.ship);
						Main.getSingleton().gameMap.addChild(policeS.ship.myAgent);
						Main.getSingleton().agents.push(policeS.ship.myAgent);

						policeS.ship.myAgent.targetX=250;
						policeS.ship.myAgent.targetY=250;
						policeS.ship.myAgent.target=Main.getSingleton().playerS.ship;
						policeS.ship.myAgent.setState(Agent.ATTACK);
						
						for each (var s2 in Main.getSingleton().getShipsList())
						{
							if(s2.isCivilianStation&&Math.random()>0.9)
							{
								x1 = s2.x;
								y1 = s2.y;
						}
					}
					
					
					
						policeS.ship.x = x1 + (Math.random() - Math.random()) * 200;
						policeS.ship.y = y1 + (Math.random() - Math.random()) * 200;
					}
					
					if(a.myShip.isAlienStation) {
						
						var alienS:AlienShip = new AlienShip();
						Main.getSingleton().gameMap.addChild(alienS);
						
						Main.getSingleton().ships.push(alienS.ship);
						Main.getSingleton().gameMap.addChild(alienS.ship.myAgent);
						Main.getSingleton().agents.push(alienS.ship.myAgent);

						alienS.ship.myAgent.targetX=150;
						alienS.ship.myAgent.targetY=150;
						alienS.ship.myAgent.target=Main.getSingleton().playerS.ship;
						alienS.ship.myAgent.setState(Agent.ATTACK);
						
						for each (var s3 in Main.getSingleton().getShipsList())
						{
							if(s3.isAlienStation&&Math.random()>0.9)
							{
								x1 = s3.x;
								y1 = s3.y;
							}
						}
					
					
					
						alienS.ship.x = x1 + (Math.random() - Math.random()) * 200;
						alienS.ship.y = y1 + (Math.random() - Math.random()) * 200;
					}
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