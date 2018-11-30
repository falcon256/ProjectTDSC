package  {
	
	
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.system.fscommand;
	import flash.display.MovieClip;
	
	public class StartScreen extends MovieClip{
			private var SScreen:MainMenu = new MainMenu();
			private var DScreen:Directions = new Directions();
	public function StartScreen() {
			// constructor code
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
		
		private function directionsScreen(evt:MouseEvent):void
		{
			removeChild(SScreen);
			trace("Here");
			
			addChild(DScreen);
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
