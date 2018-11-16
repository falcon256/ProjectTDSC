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
	
	
	[SWF(backgroundColor="0x000000")]
	public class Main extends Sprite 
	{
		private var agents:Vector.<Agent>;
		private var ships:Vector.<Ship>;
		public static var sGameMap:MovieClip = null;
		public static var targetingCursor:TargetingReticle = null;
		var playerS:PlayerShip = new PlayerShip();
		//player input key data
		private var hashKeys:Object = {};
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
			sGameMap = gameMap;
			targetingCursor = targetingReticle;
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
			agents.push(pirateS.ship.myAgent);
			
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
			
			if(isKeyDown(87))
				playerS.ship.vely+=1;
			
			moveCamera();
			movingBackground.update(gameMap.x,gameMap.y);
		}
		
		private function moveCamera()
		{
			if(agents.length>0)
			{
				gameMap.x=-agents[0].x +stage.stageWidth/2;
				gameMap.y=-agents[0].y +stage.stageHeight/2;
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

	}
	
}