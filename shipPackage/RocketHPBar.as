package shipPackage
{
	
	import flash.filters.GlowFilter;
	import flash.events.Event;
	import flash.display.MovieClip;
	import effectPackage.Smoke;
	
	public class RocketHPBar extends HeroHPBar
	{
		
		private var flameGlow:GlowFilter;
		private var smoke:Smoke;

		public function RocketHPBar() 
		{
			addEventListener(Event.ENTER_FRAME, enterFrame);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			barGlow = new GlowFilter(0xFF0000, 1, 20, 20, 4, 3, false, true);
			glow_mc.filters = [barGlow];
			flameGlow = new GlowFilter(0xFF6600, 1, 20, 20, 3, 3, false, false);
			flame_mc.filters = [flameGlow];			
		}
		
		private function addedToStage(e:Event)
		{
			smoke = new Smoke(40, 21.175);
			smoke.rotation=-90;
			stage.addChild(smoke);
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}		
		
		private function enterFrame(e:Event)
		{
			barGlow.blurX = 20*(1.0-HPBar_mc.scaleX);
			barGlow.blurY = 20*(1.0-HPBar_mc.scaleX);
			
			if(flameGlow.quality >= 3 && barGlow.quality >= 3 && this.glowGrowing)
				this.glowGrowing = false;
			else if(flameGlow.quality <= 1 && barGlow.quality <= 1 && !this.glowGrowing)
				this.glowGrowing = true;
			else if(glowGrowing)
			{
				flameGlow.quality++;
				barGlow.quality++;
			}
			else
			{
				flameGlow.quality--;
				barGlow.quality--;
			}
			glow_mc.filters = [barGlow];
			flame_mc.filters = [flameGlow];						
				
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

		override public function bringToFront()
		{
			super.bringToFront();
			if (stage) stage.setChildIndex(smoke, stage.numChildren-1);
		}

	}
	
}
