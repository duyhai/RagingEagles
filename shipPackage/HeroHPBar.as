package shipPackage
{
	import flash.filters.GlowFilter;
	import flash.filters.BitmapFilterQuality;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class HeroHPBar extends MovieClip
	{
		
		protected var barGlow:GlowFilter = null;
		protected var glowGrowing:Boolean = true;
		protected var growDelay:Number = 0;

		public function HeroHPBar()
		{	
		}
		
		public function setHP(ratio:Number)
		{
			
		}
				
		public function bringToFront()
		{
			if (stage) stage.setChildIndex(this, stage.numChildren-1);
		}
	}
	
}
