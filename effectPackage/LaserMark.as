package effectPackage
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import soundPackage.SoundMaster;
	
	public class LaserMark extends MovieClip
	{		
		
		public function LaserMark(x:Number = 0, y:Number = 0)
		{
			SoundMaster.PlayHitSound();
			this.x = x;
			this.y = y;
			addEventListener(Event.ENTER_FRAME, enterFrame);			
		}
		
		private function enterFrame(e:Event)
		{	
			if(alpha <= 0)
				kill();
			else
				alpha -= 0.1;
		}
		
		public function kill()
		{
			removeEventListener(Event.ENTER_FRAME, enterFrame);			
			parent.removeChild(this);
		}
		
	}
	
}
