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
	import game.Salvage;
	import game.Debris;
	import game.PirateStation;
	import game.Debris;
	import game.DebrisObject;
	import game.AlienStation;
	import flash.system.fscommand;
	import flash.ui.Mouse;
	import game.TradeShip;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	[SWF(backgroundColor="0x000000")]
	public class Main extends Sprite 
	{
		
		public var agents:Vector.<Agent>;
		public var ships:Vector.<Ship>;
		public var debrises:Vector.<DebrisObject>;
		public var end:Death = new Death();
		public static var sGameMap:MovieClip = null;
		public static var targetingCursor:TargetingReticle = null;
		public var playerS:PlayerShip = new PlayerShip();
		//player input key data
		private var hashKeys:Object = {};
		private static var mainSingleton:Main = null;
		private var SScreen:MainMenu = new MainMenu();
		private var DScreen:Directions = new Directions();	
		private var isStarted:Boolean = false;
		public var hud:GameHud = new GameHud();
		public var gameScore:TextField;//game score field
		public var Reputation:Number = 0;
		public var Cash:Number = 0;
		public var score:Number = 0;//score variable to store your points
		
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
			//stage.scaleMode = StageScaleMode.NO_SCALE;
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
		
		public function init(e:Event = null):void 
		{
			
			
			sGameMap = gameMap;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			stage.align = StageAlign.TOP_LEFT;
			agents = new Vector.<Agent>();
			ships = new Vector.<Ship>();
			debrises = new Vector.<DebrisObject>();
			// entry point
			//graphics.beginFill(0xeeeeee);
			//graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			
		
			var tradeS:TradeShip = new TradeShip();
		
			
			gameMap.addChild(playerS);
		
			gameMap.addChild(tradeS);
			
			
			ships.push(playerS.ship);
			
			ships.push(tradeS.ship);
			
			
			gameMap.addChild(playerS.ship.myAgent);
		
			gameMap.addChild(tradeS.ship.myAgent);
			
			addChild(hud);
			hud.y = 300;
			playerS.ship.x=100;
			
			var posx:Number = Math.random() * 10000;
			var posy:Number = Math.random() * 10000;
			var good:Boolean = true;
			var n:int = 0;
			var i:uint = 0;
			for (i = 0; i < 20; i++){
				posx = Math.random() * 10000;
				posy = Math.random() * 10000;
				good = true;

				for (n = 0; n < ships.length; n++) 
				{
					if(distance(posx,posy,ships[n].x,ships[n].y)<500)
						good=false;
				}
				if(good)
				{
					var stationS:Station = new Station();
					gameMap.addChild(stationS);
					ships.push(stationS.ship);
					gameMap.addChild(stationS.ship.myAgent);
					agents.push(stationS.ship.myAgent);
					stationS.ship.x= posx;
					stationS.ship.y= posy;
					stationS.ship.myAgent.targetX = 300;
					stationS.ship.myAgent.targetY = 300;
					stationS.ship.myAgent.setState(Agent.BUILD);
					stationS.ship.isStation=true;
				}
			}
			for (i = 0; i < 20; i++){
				posx = Math.random() * 10000;
				posy = Math.random() * 10000;
				good = true;
				for (n = 0; n < ships.length; n++) 
				{
					if(distance(posx,posy,ships[n].x,ships[n].y)<500)
						good=false;
				}
				if(good)
				{
					var pstationS:PirateStation = new PirateStation();
					gameMap.addChild(pstationS);
					ships.push(pstationS.ship);
					gameMap.addChild(pstationS.ship.myAgent);
					agents.push(pstationS.ship.myAgent);
					pstationS.ship.x= posx;
					pstationS.ship.y= posy;
					pstationS.ship.myAgent.targetX = 300;
					pstationS.ship.myAgent.targetY = 300;
					pstationS.ship.myAgent.setState(Agent.BUILD);
					pstationS.ship.isPirateStation=true;
					//trace(pstationS.ship.myAgent.x);
				}
			}
			for (i = 0; i < 20; i++){
				posx = Math.random() * 10000;
				posy = Math.random() * 10000;
				good = true;
				for (n = 0; n < ships.length; n++) 
				{
					if(distance(posx,posy,ships[n].x,ships[n].y)<500)
						good=false;
				}
				if(good)
				{
					var astationS:AlienStation = new AlienStation();
					gameMap.addChild(astationS);
					ships.push(astationS.ship);
					gameMap.addChild(astationS.ship.myAgent);
					agents.push(astationS.ship.myAgent);
					astationS.ship.x= posx;
					astationS.ship.y= posy;
					astationS.ship.myAgent.targetX = 300;
					astationS.ship.myAgent.targetY = 300;
					astationS.ship.myAgent.setState(Agent.BUILD);
					astationS.ship.isAlienStation=true;
				}
			}

		
			agents.push(tradeS.ship.myAgent);
			
			
			
			tradeS.ship.myAgent.targetX = 150;
			tradeS.ship.myAgent.targetY = 150;
			tradeS.ship.myAgent.target = stationS.ship;
			tradeS.ship.myAgent.setState(Agent.MOVETO);
			tradeS.ship.x = 200;
			
			var tf:TextFormat = new TextFormat();
			tf.size = 14;
			tf.bold = true;
			tf.font = "Arial";
			tf.color = 0xFF0000;
			
			gameScore = new TextField;//game score
			gameScore.defaultTextFormat = tf;
			gameScore.width = 200;
			gameScore.y = 680;
			gameScore.x = 1050;
		
			gameScore.text = "Reputation: 0 Cash: 0" ;
			addChild(gameScore);
			
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
			if(playerS.ship.hull <= 0)
			{
				removeEventListener(Event.ENTER_FRAME, gameloop);
				Mouse.show();
				addChild(end);
				end.RetryBtn.addEventListener(MouseEvent.CLICK, retry);
				end.BackToMenuBtn.addEventListener(MouseEvent.CLICK, exit);
			}
			//trace("Gamemap children: "+gameMap.numChildren+" ships: "+ships.length);
			
			
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
		
		public function getDebrisList():Vector.<DebrisObject>
		{
			return debrises;
		}		
		public function retry(evt:MouseEvent){
		
			
			
			freshStart();
			removeChild(end);
			removeEventListener(MouseEvent.CLICK,retry);
			
			
		}
		public function freshStart():void{
			
		}
		public function exit(evt:MouseEvent){
		
			fscommand("quit");
			trace("If this was an exe I believe I would quit!!");
		}
		
		private function directionsScreen(evt:MouseEvent):void
		{
			removeChild(SScreen);
			//trace("Here");
			
			
			addChild(DScreen);
			DScreen.BackBtn.addEventListener(MouseEvent.CLICK, directionsScreenClose);
		}
		
		private function directionsScreenClose(evt:MouseEvent):void
		{			
			//trace("There");	
			removeChild(DScreen);
			addChild(SScreen);
		}
		private function exitScreen(evt:MouseEvent):void{
			fscommand("quit");
			trace("If this was an exe I believe I would quit!!");
		}
		
		private function createGame():void
		{
			//trace("hi");
		}
		
		public function removeDebris(s:DebrisObject)
		{		
			for (var i:int = 0; i < debrises.length; i++) 
			{
				 if (s == debrises[i])
					  debrises.splice(i,1);
			}
		}
		
		public function removeShip(s:Ship)
		{
			
			for (var i:int = 0; i < ships.length; i++) 
			{
				 if (s == ships[i])
					  ships.splice(i,1);
			}
			
			var debris:DebrisObject = new DebrisObject();
			//trace(debris);
			debrises.push(debris);
			gameMap.addChild(debris.debrisClip);
			debris.debrisClip.x = s.x;
			debris.debrisClip.y = s.y;
			debris.x = s.x;
			debris.y = s.y;
			
			
				
			s.myImage.parent.removeChild(s.myImage);
		}
		public static function distance(x1:Number,y1:Number,x2:Number,y2:Number):Number
		{
			return Math.sqrt(((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2)));
		}
		
	}
	
}