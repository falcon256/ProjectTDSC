package game {
	
		//Systems control proportional integral derivative loop
		//author : Daniel Lambert
		//Used in this project for missile augmented proportional navagation,
	
	public class PID {
		private var P:Number = 0.1;
		private var I:Number = 0.1;
		private var D:Number = 0.1;
		private var current:Number = 0;
		private var errorSum:Number = 0;
		
		public function PID(p:Number, i:Number, d:Number) {
			P=p;
			I=i;
			D=d;
		}
		
		public function tick(t:Number):Number
		{

			var last:Number = current;
			var error:Number = t-current;
			errorSum+=error;
			var POut:Number= P*error;
			var IOut:Number= I*errorSum;
			var DOut:Number= -D*(current-last);
			//trace(t+" "+POut+" "+IOut+" "+DOut);
			return POut+IOut+DOut;
		}
	
	}
	
}
