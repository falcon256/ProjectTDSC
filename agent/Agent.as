package agent 
{
	import agent.states.ChaseState;
	import agent.states.ConfusionState;
	import agent.states.FleeState;
	import agent.states.IAgentState;
	import agent.states.IdleState;
	import agent.states.WanderState;
	import agent.states.MoveToState;
	import agent.states.GrabShipState;
	import agent.states.AttackState;
	import agent.states.SalvageState;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import game.GameParameters;
	import game.Ship;

	public class Agent extends Sprite
	{
		public static const IDLE:IAgentState = new IdleState(); //Define possible states as static constants
		public static const WANDER:IAgentState = new WanderState();
		public static const CHASE:IAgentState = new ChaseState();
		public static const FLEE:IAgentState = new FleeState();
		public static const CONFUSED:IAgentState = new ConfusionState();
		public static const MOVETO:IAgentState = new MoveToState();
		public static const ATTACK:IAgentState = new AttackState();
		public static const GRABSHIP:IAgentState = new GrabShipState();
		public static const SALVAGE:IAgentState = new SalvageState();
		
		private const RAD_DEG:Number = 180 / Math.PI;
		
		private var _previousState:IAgentState; //The previous executing state
		private var _currentState:IAgentState; //The currently executing state
		private var _pointer:Shape;
		private var _tf:TextField;
		public var velocity:Point = new Point();
		public var speed:Number = 0;
		public var fleeRadius:Number = 50; //If the mouse is "seen" within this radius, we want to flee
		public var chaseRadius:Number = 150; //If the mouse is "seen" within this radius, we want to chase
		public var numCycles:int = 0; //Number of updates that have executed for the current state. Timing utility.
		
		public var targetX:Number=0;
		public var targetY:Number=0;
		public var target:Ship = null;
		public function Agent() 
		{
			//Boring stuff here
			_tf = new TextField();
			_tf.defaultTextFormat = new TextFormat("_sans", 10);
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_pointer = new Shape();
			var g:Graphics = _pointer.graphics;
			/*
			g.beginFill(0xFFFFFF);
			g.drawCircle(0, 0, 5);
			g.endFill();
			g.moveTo(0, -5);
			g.beginFill(0xFFFFFF);
			g.lineTo(10, 0);
			g.lineTo(0, 5);
			g.endFill();
			addChild(_pointer);
			addChild(_tf);
			graphics.lineStyle(0, 0xFF0000, .2);
			graphics.drawCircle(0, 0, fleeRadius);
			graphics.lineStyle(0, 0x00FF00,.2);
			graphics.drawCircle(0, 0, chaseRadius);*/
			
			_currentState = MOVETO; //Set the initial state
		}
		/**
		 * Outputs a line of text above the agent's head
		 * @param	str
		 */
		public function say(str:String):void {
			_tf.text = str;
			_tf.y = -_tf.height - 2;
		}
			
		/**
		 * Trig utility methods
		 */
		public function get canSeeMouse():Boolean {
			var dot:Number = ((mouseX-Main.sGameMap.x)-x) * velocity.x + ((mouseY-Main.sGameMap.y)-y) * velocity.y;
			//trace(""+(mouseX-Main.sGameMap.x)+" "+(mouseY-Main.sGameMap.y));
			return dot > 0;
		}
		public function get distanceToMouse():Number {
			var dx:Number = x - (mouseX-Main.sGameMap.x);
			var dy:Number = y - (mouseY-Main.sGameMap.y);
			return Math.sqrt(dx * dx + dy * dy);
		}
		
		public static function distance1(x1:Number,y1:Number):Number
		{
			return Math.sqrt(((x1)*(x1))+((y1)*(y1)));
		}
		
		public static function distance2(x1:Number,y1:Number,x2:Number,y2:Number):Number
		{
			return Math.sqrt(((x1-x2)*(x1-x2))+((y1-y2)*(y1-y2)));
		}
		
		
		public function randomDirection():void {
			var a:Number = Math.random() * 6.28;
			velocity.x = Math.cos(a);
			velocity.y = Math.sin(a);
		}
		public function faceMouse(multiplier:Number = 1):void {
			var dx:Number = ((mouseX-Main.sGameMap.x) - x);
			var dy:Number = ((mouseY-Main.sGameMap.y) - y);
			var rad:Number = Math.atan2(dy, dx);
			velocity.x += multiplier*Math.cos(rad)*0.1;
			velocity.y += multiplier*Math.sin(rad)*0.1;
		}
		
		/**
		 * Update the current state, then update the graphics
		 */
		public function update():void {
			
			if (!_currentState)
			{
				trace("Agent has no state");
				return; //If there's no behavior, we do nothing
			}
			numCycles++; 
			_currentState.update(this);
			x += velocity.x;//*speed;
			y += velocity.y;//*speed;
			

			_pointer.rotation = RAD_DEG * Math.atan2(velocity.y, velocity.x);
		}
		public function setState(newState:IAgentState):void {
			trace(_currentState);
			if (_currentState == newState) return;
			if (_currentState) {
				_currentState.exit(this);
			}
			_previousState = _currentState;
			_currentState = newState;
			_currentState.enter(this);
			numCycles = 0;
		}
		
		public function get previousState():IAgentState { return _previousState; }
		
		public function get currentState():IAgentState { return _currentState; }
		
	}

}