package shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	
	public class EnemyShipStinger extends EnemyShipX22Fighter{
		
		public function EnemyShipStinger(firerate:Number = EnumFireRate.LEVEL_FOUR, health:Number = EnumHealth.LEVEL_THREE, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_THREE;
			maxspeedx=EnumSpeed.LEVEL_FOUR;
			maxspeedy=EnumSpeed.LEVEL_THREE;
		}
		
		override protected function shoot(){
			if (stage) stage.addChild(new LaserBlast(false, bulletdamage+damagebonus, new Vector2D(this.x-45, this.y-13), new Vector2D(-10+velocity.x,0)));
		}
		
		override public function collide():Number
		{
			return super.collide()*3;
		}
	}
	
}