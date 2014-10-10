package shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	import flash.events.Event;
	
	public class EnemyShipMeltdownZero extends EnemyShip{
		
		var laserBullet:EnemyLaserBeam;
		var fire:Boolean;
		
		public function EnemyShipMeltdownZero(firerate:Number = EnumFireRate.LEVEL_FIVE, health:Number = EnumHealth.LEVEL_THREE, pos:Vector2D=null, velocity:Vector2D = null)
		{
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_TWO/firerate;	//ezt lehet hogy még csökkenteni kéne mert a lézer folyamatos, és framenként sebez
			maxspeedx=EnumSpeed.LEVEL_THREE;
			maxspeedy=EnumSpeed.LEVEL_THREE;
		}
		
		override protected function enterFrame(e:Event)
		{
			super.enterFrame(e);
			
			if (!fire)
				if (GameClass.heroShip.y>this.y-60 && GameClass.heroShip.y<this.y+60
					&& Math.floor(Math.random()*10)==0) fire = true;
			else
				if ((GameClass.heroShip.y<this.y-60 || GameClass.heroShip.y>this.y+60)
					&& Math.floor(Math.random()*10)==0) fire = false;
			
			if (!laserBullet && fire) checkFire();
			if (laserBullet && !fire) 
			{	
				laserBullet.kill();
				laserBullet=null;
			}
		}
		
		override public function kill()
		{
			if (killed) return;
			if (laserBullet) laserBullet.kill();
			super.kill();
		}
		
		override protected function shoot()
		{
			laserBullet = new EnemyLaserBeam(this, 0, 1, new Vector2D(this.x-25,this.y+10), new Vector2D(0,0));
			if (stage) stage.addChild(laserBullet);
		}
		
	}
}