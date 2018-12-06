package 
{
	import agent.Agent;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import game.PlayerShip;
	import game.PirateShip;
	import game.PoliceShip;
	import game.AlienShip;
	import game.Ship;
	import game.Station;
	import flash.system.fscommand;
	import flash.ui.Mouse;
	
	[SWF(backgroundColor="0x000000")]
	public class Main extends Sprite 
	{
		private var agents:Vector.<Agent>;
		private var ships:Vector.<Ship>;
		
		public static var sGameMap:MovieClip = null;
		public static var targetingCursor:TargetingReticle = null;
		public var playerS:PlayerShip = new PlayerShip();
		//player input key data
		private var hashKeys:Object = {};
		private static var mainSingleton:Main = null;
		private var SScreen:MainMenu = new MainMenu();
		private var DScreen:Directions = new Directions();	
		private var isStarted:Boolean = false;
		
		//Reid and Ross additions
		
		public function Main():void 
		{
			if(mainSingleton==null)
				mainSingleton = this;
			else
				return;
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			sGameMap = gameMap;
			targetingCursor = targetingReticle;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			Mouse.show();
			createStartMenu();
		}
		private function createStartMenu():void{
			
			
			addChild(SScreen);
			
			
			
			
			SScreen.StartBtn.addEventListener(MouseEvent.CLICK, startGame);//Links the button press to the intro clip
			SScreen.DirectionsBtn.addEventListener(MouseEvent.CLICK, directionsScreen);
			SScreen.ExitBtn.addEventListener(MouseEvent.CLICK, exitScreen);
		}
		
		private function startGame(evt:MouseEvent):void
		{	
			removeChild(SScreen);//removes start screen
			Mouse.hide();
			isStarted=true;
			createGame();//runs game
			
			
		
		}
		
		private function init(e:Event = null):void 
		{
			sGameMap = gameMap;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			agents = new Vector.<Agent>();
			ships = new Vector.<Ship>();
			// entry point
			//graphics.beginFill(0xeeeeee);
			//graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			
			var pirateS:PirateShip = new PirateShip();
			var policeS:PoliceShip = new PoliceShip();
			var alienS:AlienShip = new AlienShip();
		
			
			gameMap.addChild(playerS);
			gameMap.addChild(pirateS);
			gameMap.addChild(policeS);
			gameMap.addChild(alienS);
			
			
			ships.push(playerS.ship);
			ships.push(pirateS.ship);	
			ships.push(policeS.ship);
			ships.push(alienS.ship);
			
			
			gameMap.addChild(playerS.ship.myAgent);
			gameMap.addChild(pirateS.ship.myAgent);
			gameMap.addChild(policeS.ship.myAgent);
			gameMap.addChild(alienS.ship.myAgent);
			
			
			playerS.ship.x=100;
			pirateS.ship.x=-100;
			for (var i:uint = 0; i < 20; i++){
				trace("hello");
				var stationS:Station = new Station();
				gameMap.addChild(stationS);
				ships.push(stationS.ship);
				gameMap.addChild(stationS.ship.myAgent);
				agents.push(stationS.ship.myAgent);
				stationS.ship.x= Math.random() * 10000;
				stationS.ship.y= Math.random() * 10000;
				stationS.ship.myAgent.targetX = 300;
				stationS.ship.myAgent.targetY = 300;
				stationS.ship.myAgent.setState(Agent.STATION);
			}
			agents.push(pirateS.ship.myAgent);
			agents.push(policeS.ship.myAgent);
			agents.push(alienS.ship.myAgent);
			
			
			pirateS.ship.myAgent.targetX=500;
			pirateS.ship.myAgent.targetY=500;
			pirateS.ship.myAgent.target=playerS.ship;
			pirateS.ship.myAgent.setState(Agent.ATTACK);
			
			policeS.ship.myAgent.targetX=250;
			policeS.ship.myAgent.targetY=250;
			policeS.ship.myAgent.target=pirateS.ship;
			policeS.ship.myAgent.setState(Agent.ATTACK);
			
			alienS.ship.myAgent.targetX=150;
			alienS.ship.myAgent.targetY=150;
			alienS.ship.myAgent.target=policeS.ship;
			alienS.ship.myAgent.setState(Agent.ATTACK);
			
			
			
			
			
			
			addEventListener(Event.ENTER_FRAME, gameloop);
			/*for (var i:int = 0; i < 1; i++) 
			{
				var a:Agent = new Agent();
				gameMap.addChild(a);
				agents.push(a);
				a.x = stage.stageWidth/2
				a.y = stage.stageHeight/2
			}*/
			
			//stage.addEventListener(MouseEvent.CLICK, createAgent);//old test code		
			stage.addEventListener(KeyboardEvent.KEY_UP, keyHandleUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyHandleDown);


		}
		
		private function createAgent(e:MouseEvent):void 
		{
			var a:Agent = new Agent();
			gameMap.addChild(a);
			agents.push(a);
			a.x = mouseX-gameMap.x;
			a.y = mouseY-gameMap.y;

		}
		
		private function gameloop(e:Event):void 
		{
			if(!isStarted)
				return;
			for (var i:int = 0; i < ships.length; i++) 
			{
				ships[i].doUpdate();
			}
			
			if(isKeyDown(87)) {//w key for foward
				playerS.ship.velx+= 0.5 * Math.cos(Ship.radians(playerS.ship.rotation));
				playerS.ship.vely+= 0.5 * Math.sin(Ship.radians(playerS.ship.rotation));
			}
			
			if(isKeyDown(68)) {//d key to rotate right
				playerS.ship.rotation += 4;
				
			}
			
			if(isKeyDown(65)) {//a key to rotate left
				playerS.ship.rotation += -4;
				
			}
			if(isKeyDown(83)){//s key to reverse 
					playerS.ship.velx-= 0.4 * Math.cos(Ship.radians(playerS.ship.rotation));
					playerS.ship.vely-= 0.4 * Math.sin(Ship.radians(playerS.ship.rotation));
			}
			
			if(isKeyDown(32)){//space for railing
					playerS.ship.fireRailgun();
			}
			
			moveCamera();
			movingBackground.update(gameMap.x,gameMap.y);
		}
		
		private function moveCamera()
		{
			if(agents.length>0)
			{
				gameMap.x=-playerS.x +stage.stageWidth/2;
				gameMap.y=-playerS.y +stage.stageHeight/2;
			}
			testMouseLoc()
		}
		
		private function testMouseLoc()
		{
			if(agents.length>0)
			{
				//agents[0].x = mouseX-gameMap.x;
				//agents[0].y = mouseY-gameMap.y;
				//trace(""+((mouseX-gameMap.x)-agents[0].x)+" "+((mouseY-gameMap.y)-agents[0].y));
			}
		}
		


		private function keyHandleUp(event:KeyboardEvent):void {
			delete hashKeys[event.keyCode];
		}

		private function keyHandleDown(event:KeyboardEvent):void {
			hashKeys[event.keyCode] = 1;
		}

		private function isKeyDown(code:int):Boolean {
			return hashKeys[code] !== undefined;
		}
		
		public static function getSingleton():Main
		{
			return mainSingleton;
		}
		
		public function getShipsList():Vector.<Ship>
		{
			return ships;
		}
		private function directionsScreen(evt:MouseEvent):void
		{
			removeChild(SScreen);
			trace("Here");
			
			
			addChild(DScreen);
			DScreen.BackBtn.addEventListener(MouseEvent.CLICK, directionsScreenClose);
		}
		
		private function directionsScreenClose(evt:MouseEvent):void
		{			
			trace("There");	
			removeChild(DScreen);
			addChild(SScreen);
		}
		private function exitScreen(evt:MouseEvent):void{
			fscommand("quit");
			trace("If this was an exe I believe I would quit!!");
		}
		
		private function createGame():void
		{
			trace("hi");
		}
		
		public function removeShip(s:Ship)
		{
			trace("Test");
			//stolen from the web
			for (var i:int = 0; i < ships.length; i++) 
			{
				 if (s == ships[i])
					  ships.splice(i,1);
			}
			s.myImage.parent.removeChild(s.myImage);
		}
		
	}
	
}