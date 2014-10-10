package  shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class EnemyShipX22Commander extends EnemyShip {
		
		public function EnemyShipX22Commander(firerate:Number = EnumFireRate.LEVEL_THREE, health:Number = EnumHealth.LEVEL_FOUR, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_FOUR;
			maxspeedx=EnumSpeed.LEVEL_FOUR;
			maxspeedy=EnumSpeed.LEVEL_THREE;
			
			var n:Number=0;
			for(var i in EnemyShip.list)
				if (EnemyShip.list[i].x<=800 && EnemyShip.list[i].x>=0 &&
					EnemyShip.list[i].y<=450 && EnemyShip.list[i].y>=0) n++
			n--;
			health*=(1+(0.1*n));
			for(var j in EnemyShip.list)
				if (EnemyShip.list[j]!=this&&
					EnemyShip.list[j].x<=800 && EnemyShip.list[j].x>=0 &&
					EnemyShip.list[j].y<=450 && EnemyShip.list[j].y>=0)
					EnemyShip.list[j].setBonus(n,this);
		}
		
		override protected function enterFrame(e:Event){
			super.enterFrame(e);
			if (x<700)
			{
				if (Math.abs(velocity.x)>1) velocity.x*=0.8;
				else velocity.x=0;
				
				if (Math.abs(velocity.y)<5) velocity.y*=1.1;
			}
			if (y<50 && velocity.y<0) velocity.y*=-1;
			if (y>450 && velocity.y>0) velocity.y*=-1;
			
			checkFire();
			damagebonus=0;
		}
		
		override protected function shoot(){
			if (stage) stage.addChild(new LaserBlast(false, bulletdamage+damagebonus, new Vector2D(this.x+5, this.y+18), new Vector2D(-10+velocity.x,0), 255, 100, 100));
		}
		
		override public function kill()
		{
			for(var i in EnemyShip.list)
				if (EnemyShip.list[i].bonusSender==this)
				{
					EnemyShip.list[i].setBonus(0,null);
				}
			super.kill();
		}
	}
	
}
