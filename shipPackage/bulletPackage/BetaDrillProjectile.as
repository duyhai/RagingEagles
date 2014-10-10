package shipPackage.bulletPackage
{	

	import effectPackage.*;
	import flash.display.MovieClip;
	
	public class BetaDrillProjectile extends Bullet
	{
		 
		 public function BetaDrillProjectile(ishero:Boolean=false, damage:Number=10, pos:Vector2D=null, velocity:Vector2D = null)
		 {
			 super(ishero, damage,pos,velocity);
		 }

		override public function giveDamage(target:MovieClip):Number
		{
			if(target)
			{
				if(velocity.x > 0)
					target.addChild(new LaserMark(x+width-target.x, y-target.y));
				else
					target.addChild(new LaserMark(x-width-target.x, y-target.y));
			}
				
			this.kill();
			return damage;
		}

	}
}