package effectPackage
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Smoke extends MovieClip
	{
		
		private var killSwitch = false;
		
		public function Smoke(x:Number = 0, y:Number = 0) 
		{
			this.x = x;
			this.y = y;
			addEventListener(Event.ENTER_FRAME, enterFrame, false, 0, true);
		}

		private function enterFrame(e:Event) : void
		{
			if(!killSwitch) addChild(new SmokePuff());
			
			if(this.numChildren == 0 && killSwitch)
			{
				removeEventListener("enterFrame", enterFrame);   
            	stage.removeChild(this);
			}
		}
		
		public function kill()
        {
            killSwitch = true;
        }

	}
	
}
