package shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	
	public class EnemyShipHunterRAVEN extends EnemyShipX22Fighter{
		
		public function EnemyShipHunterRAVEN(firerate:Number = EnumFireRate.LEVEL_THREE, health:Number = EnumHealth.LEVEL_THREE, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_THREE;
			maxspeedx=EnumSpeed.LEVEL_THREE;
			maxspeedy=EnumSpeed.LEVEL_FOUR;
		}
		
		override protected function shoot(){
			if (stage) stage.addChild(new LaserBlast(false, bulletdamage+damagebonus, new Vector2D(this.x, this.y+16), new Vector2D(-10+velocity.x,0)));
		}
	}
	
}