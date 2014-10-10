package shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	
	public class EnemyShipChitinB extends EnemyShipX22Fighter{
		
		public function EnemyShipChitinB(firerate:Number = EnumFireRate.LEVEL_FOUR, health:Number = EnumHealth.LEVEL_FOUR, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_THREE;
			maxspeedx=EnumSpeed.LEVEL_THREE;
			maxspeedy=EnumSpeed.LEVEL_TWO;
		}
		
		override protected function shoot(){
			if (stage) stage.addChild(new LaserBlast(false, bulletdamage+damagebonus, new Vector2D(this.x-45, this.y-13), new Vector2D(-10+velocity.x,0)));
		}
	}
	
}