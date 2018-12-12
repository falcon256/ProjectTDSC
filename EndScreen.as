package  {
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	public class EndScreen extends MovieClip{

		public function EndScreen() {
			// constructor code
			addChild(Death);
			
			Death.RetryBtn.addEventListener(MouseEvent.CLICK,retry);
			Death.BackToMenuBtn.addEventListener(MouseEvent.CLICK, exit);
		}
		public function retry(evt:MouseEvent){
			
		}
		public function exit(evt:MouseEvent){
			
		}

	}
	
}
