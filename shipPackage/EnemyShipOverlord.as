package shipPackage{
	
	import enumPackage.*;
	import flash.events.Event;
	
	public class EnemyShipOverlord extends EnemyShip{
		
		var shield:Number=0;

		public function EnemyShipOverlord(firerate:Number = 0, health:Number = EnumHealth.LEVEL_THREE, pos:Vector2D=null, velocity:Vector2D = null)
		{
			super(firerate, health, pos, velocity);
			bulletdamage=0;
			maxspeedx=EnumSpeed.LEVEL_THREE;
			maxspeedy=EnumSpeed.LEVEL_THREE;
		}
		
		override protected function enterFrame(e:Event)
		{
			super.enterFrame(e);
			shield+=0.3;
			if (shield>=maxhealth) shieldExplode();
		}
		
		protected function shieldExplode()
		{
			shield=0;
			GameClass.heroShip.paralyze();
			for (var i in EnemyShip.list)
			{
				EnemyShip.list[i].paralyze();
			}
		}
		
	}
	
}