package shipPackage.bulletPackage {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import effectPackage.*;
	
	public class EnergyBall extends Bullet {
		
		public function EnergyBall(ishero:Boolean = false, dmg:Number = 10, pos:Vector2D = null, velocity:Vector2D = null) {
			super(ishero, dmg, pos, velocity);
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
