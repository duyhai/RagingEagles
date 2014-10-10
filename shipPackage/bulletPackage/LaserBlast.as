package shipPackage.bulletPackage {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import effectPackage.LaserMark;
	import flash.filters.GlowFilter;
	
	public class LaserBlast extends Bullet {
		
		public function LaserBlast(ishero:Boolean = false, dmg:Number = 10, pos:Vector2D = null, velocity:Vector2D = null, red:Number = 255, green:Number = 255, blue:Number = 255) {
			super(ishero, dmg, pos, velocity);
			if(velocity.x < 0)
				rotation = 180;
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.redOffset = red;
			colorTransform.greenOffset = green;
			colorTransform.blueOffset = blue;		
			Glow.filters = [new GlowFilter(colorTransform.color, 1, 5, 5, 1, 3, false, false)];
			Glow.transform.colorTransform = colorTransform;	
		}
		
		override public function giveDamage(target:MovieClip):Number
		{
			if(target)	
			{
				//if(velocity.x > 0)
					//target.addChild(new LaserMark(x+width-target.x, y-target.y));
				//else
					target.addChild(new LaserMark(x-width-target.x, y-target.y));
			}
			
				
			this.kill();
			return damage;
		}
	}
	
}
