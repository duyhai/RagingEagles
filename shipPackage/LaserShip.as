package shipPackage
{
	
	import shipPackage.bulletPackage.*;
	import menuPackage.*;
	import flash.events.Event;
    import flash.display.MovieClip;
	
	import flash.system.System;
	
	public class LaserShip extends HeroShip
	{
		var laserBullet:LaserBeam;
		
		public function LaserShip(firerate:Number = 5, health:Number = 600, pos:Vector2D = null)
		{
			super(firerate,health,pos);
		}
		
		override protected function enterFrame(e:Event){
			//trace(new Number(System.totalMemory/1024).toFixed(2));
			pcounter--;
			if (pcounter<=0) 
			{
				paralyzed=false;
				pcounter=60;
			}
			if (paralyzed) return;
			
			destination.x=stage.mouseX;
			destination.y=stage.mouseY;
			
			this.x=(this.x*0.6+destination.x*0.4);
			this.y=(this.y*0.6+destination.y*0.4);
			
			if(fireCount > 0) fireCount--;
			if (!laserBullet && isMouseDown) checkFire();
			if (laserBullet && !isMouseDown) 
			{	
				laserBullet.kill();
				laserBullet=null;
			}
		} //Ide majd kell egy if(fireCount > 0) fireCount--;
		
		override protected function shoot()
		{
			if (TalentMenu.Instance(stage).GetSpecTalent().GetTalent(3)>0)
				laserBullet = new NightMareLaserBeam(this, 0, 1, new Vector2D(this.x+44,this.y+10), new Vector2D(0,0));
			else
				laserBullet = new LaserBeam(this, 0, 1, new Vector2D(this.x+44,this.y+10), new Vector2D(0,0));
			stage.addChild(laserBullet);
		}
	}
}