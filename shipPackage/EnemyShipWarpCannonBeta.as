package shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	
	public class EnemyShipWarpCannonBeta extends EnemyShipChitinB{
		
		public function EnemyShipWarpCannonBeta(firerate:Number = EnumFireRate.LEVEL_TWO, health:Number = EnumHealth.LEVEL_THREE, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_FIVE;
			maxspeedx=EnumSpeed.LEVEL_THREE;
			maxspeedy=EnumSpeed.LEVEL_THREE;
		}
		
		override protected function shoot(){
			if (stage) stage.addChild(new EnergyBall(false, bulletdamage+damagebonus, new Vector2D(this.x-50, this.y+6), new Vector2D(-10+velocity.x,0)));
		}
		
	}
	
}