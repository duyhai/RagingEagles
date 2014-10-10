package shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	
	public class EnemyShipChitinA extends EnemyShipChitinB{
		
		public function EnemyShipChitinA(firerate:Number = EnumFireRate.LEVEL_THREE, health:Number = EnumHealth.LEVEL_FIVE, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_FOUR;
			maxspeedx=EnumSpeed.LEVEL_TWO;
			maxspeedy=EnumSpeed.LEVEL_TWO;
		}
		
		override protected function shoot(){
			if (stage) stage.addChild(new EnergyBall(false, bulletdamage+damagebonus, new Vector2D(this.x-20, this.y+13), new Vector2D(-10+velocity.x,0)));
		}
		
	}
	
}