

package effectPackage
{
 
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
 
	public class SmokePuff extends MovieClip
	{
 
		public var vx:Number;
		public var vy:Number;
		public var rs:Number;
 
		public function SmokePuff(x:Number = 0, y:Number = 0)
		{
			this.x = x;
			this.y = y;
			alpha = Math.random();
			vx = Math.random() - Math.random();
			vy = Math.random() * 3 - 5;
			scaleX = scaleY = Math.random();
			rs = Math.random() * 6 - 3;
			
			addEventListener(Event.ENTER_FRAME, enterFrame, false, 0, true);
		}
 
		private function enterFrame(e:Event) : void
		{
			rotation += rs;
			alpha -= 0.01;
			y += vy;
			x += vx;
			scaleX = scaleY += 0.02;
 
			if (alpha < 0)
				removeSelf();
		}
 
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			parent.removeChild(this);
		}
 
	}
 
}

