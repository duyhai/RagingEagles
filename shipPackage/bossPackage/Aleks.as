package shipPackage.bossPackage {
	
	import shipPackage.*;
	import enumPackage.*;
	import flash.events.Event;
	
	public class Aleks extends EnemyShip{
		
		
		public function Aleks(firerate:Number = EnumFireRate.LEVEL_FIVE, health:Number = EnumHealth.LEVEL_FIVE, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_FIVE;
			maxspeedx=EnumSpeed.LEVEL_FIVE;
			maxspeedy=EnumSpeed.LEVEL_FIVE;
		}
		
		override protected function enterFrame(e:Event)
		{
			if (velocity.x<0 && x<=550) velocity.x*=-1;
			if (velocity.x>0 && x>=800) velocity.x*=-1;
			super.enterFrame(e);
		}
		
	}
	
}
