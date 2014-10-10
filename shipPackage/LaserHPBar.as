package shipPackage
{
	
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import flash.display.MovieClip;
	public class LaserHPBar extends HeroHPBar
	{

		public function LaserHPBar() 
		{
			addEventListener(Event.ENTER_FRAME, enterFrame);
			barGlow = new GlowFilter(0xFF0000, 1, 20, 20, 4, 3, false, true);
			glow_mc.filters = [barGlow];
		}
		
		private function enterFrame(e:Event)
		{
			barGlow.blurX = 40*(1.0-HPBar_mc.scaleX);
			barGlow.blurY = 40*(1.0-HPBar_mc.scaleX);
			
			if(barGlow.quality >= 3 && this.glowGrowing)
				this.glowGrowing = false;
			else if(barGlow.quality <= 1 && !this.glowGrowing)
				this.glowGrowing = true;
			else if(glowGrowing)
			{
				barGlow.quality++;
			}
			else
			{
				barGlow.quality--;
			}
			glow_mc.filters = [barGlow];
				
			if(growDelay > 0)
				growDelay--;
			else
			{
				if(fade_mc.scaleX >= 1+0.3*(1.0-HPBar_mc.scaleX) || fade_mc.scaleY >= 1+0.3*(1.0-HPBar_mc.scaleX) || fade_mc.alpha <= 0)
				{
					growDelay = 30;
					fade_mc.alpha = 1;
					fade_mc.scaleX = 1;
					fade_mc.scaleY = 1;
				}
				else
				{
					fade_mc.alpha -= 0.033;
					fade_mc.scaleX += 0.01*(1.0-HPBar_mc.scaleX);
					fade_mc.scaleY += 0.01*(1.0-HPBar_mc.scaleX);
				}
			}
				
		}
		
		override public function setHP(ratio:Number)
		{
			HPBar_mc.scaleX = ratio;
		
		}

	}
	
}
