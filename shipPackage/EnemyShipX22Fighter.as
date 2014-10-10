package  shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class EnemyShipX22Fighter extends EnemyShip {
		
		public function EnemyShipX22Fighter(firerate:Number = EnumFireRate.LEVEL_THREE, health:Number = EnumHealth.LEVEL_THREE, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_THREE;
			maxspeedx=EnumSpeed.LEVEL_FOUR;
			maxspeedy=EnumSpeed.LEVEL_THREE;
		}
		
		override protected function enterFrame(e:Event){
			super.enterFrame(e);
			if (damagebonus==0)
			{
				if (velocity.x==0) velocity.x=Math.random()*(-5)-3;
			}
			else if (x<=800 && x>=0 && y<=450 && y>=0)
			{
				if (Math.abs(velocity.x)>1) velocity.x*=0.8;
				else velocity.x=0;
				
				if (y<50 && velocity.y<0) velocity.y*=-1;
				if (y>450 && velocity.y>0) velocity.y*=-1;
			}
			checkFire();
		}
		
		override protected function shoot(){
			if (stage) stage.addChild(new LaserBlast(false, bulletdamage+damagebonus, new Vector2D(this.x+5, this.y+18), new Vector2D(-10+velocity.x,0), 100, 255, 100));
		}
	}
	
}
