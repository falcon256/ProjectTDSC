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
	import game.Ship;
	import game.Station;
	import flash.system.fscommand;
	
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
		
		
		//Reid and Ross additions
		public var shopstation:Station = new Station();
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
			gameMap.addChild(playerS);
			gameMap.addChild(pirateS);
			
			ships.push(playerS.ship);
			ships.push(pirateS.ship);	
			
			gameMap.addChild(playerS.ship.myAgent);
			gameMap.addChild(pirateS.ship.myAgent);
			
			playerS.ship.x=100;
			pirateS.ship.x=-100;
			
			agents.push(pirateS.ship.myAgent);
			
			pirateS.ship.myAgent.targetX=500;
			pirateS.ship.myAgent.targetY=500;
			pirateS.ship.myAgent.setState(Agent.MOVETO);
			
			gameMap.addChild(shopstation);
			shopstation.x = 250;
			shopstation.y = 250;
			
			
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
			DScreen.BackBtn.addEventListener(MouseEvent.CLICK, createStartMenu);
		}
		
		private function exitScreen(evt:MouseEvent):void{
			fscommand("quit");
			trace("If this was an exe I believe I would quit!!");
		}
		
		private function createGame():void
		{
			trace("hi");
		}
	}
	
}