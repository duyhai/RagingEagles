package shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	
	public class EnemyShipOmegaFighter extends EnemyShipX22Fighter{
		
		public function EnemyShipOmegaFighter(firerate:Number = EnumFireRate.LEVEL_THREE, health:Number = EnumHealth.LEVEL_THREE, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_FOUR;
			maxspeedx=EnumSpeed.LEVEL_FOUR;
			maxspeedy=EnumSpeed.LEVEL_THREE;
		}
		
		override protected function shoot(){
			var m:HomingMissile = new HomingMissile(false, 60, bulletdamage+damagebonus, new Vector2D(this.x, this.y+10), new Vector2D(-10+velocity.x,0));
			m.rotationZ=180;
			if (stage) stage.addChild(m);
		}
	}
	
}