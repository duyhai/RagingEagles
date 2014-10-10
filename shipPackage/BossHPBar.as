package shipPackage
{
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class BossHPBar extends MovieClip
	{
		
		public function BossHPBar()
		{	
		}
		
		public function setHP(ratio:Number)
		{
			HPBar_mc.scaleX = ratio;
		}
				
		public function bringToFront()
		{
			if (stage) stage.setChildIndex(this, stage.numChildren-1);
		}
	}
	
}
