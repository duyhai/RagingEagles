package shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	import flash.events.Event;
	
	public class EnemyShipMegaDrillBeta extends EnemyShip{
		
		var drill0:X9DrillProjectile=null;
		
		public function EnemyShipMegaDrillBeta(firerate:Number = EnumFireRate.LEVEL_THREE, health:Number = EnumHealth.LEVEL_FIVE, pos:Vector2D = null, velocity:Vector2D = null)
		{
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_THREE;
			maxspeedx=EnumSpeed.LEVEL_FOUR;
			maxspeedy=EnumSpeed.LEVEL_ONE;
			addEventListener(Event.ADDED,addedtoStage);
		}
		
		protected function addedtoStage(e:Event)
		{
			drill0 = new X9DrillProjectile(this, false, bulletdamage+damagebonus, new Vector2D(-34,0),0);
			drill0.rotationZ=180;
			stage.addChild(drill0);
			removeEventListener(Event.ADDED, addedtoStage);
		}
		
		override protected function enterFrame(e:Event)
		{
			super.enterFrame(e);
			if (GameClass.heroShip.y>this.y-60 && GameClass.heroShip.y<this.y+60) checkFire();
		}
		
		override public function kill()
		{
			drill0.kill();
			drill0=null;
			super.kill();
			killed=true;
		}
		
		override protected function shoot()
		{
			var drill1:BetaDrillProjectile = new BetaDrillProjectile(false, bulletdamage+damagebonus, new Vector2D(this.x-34,this.y),new Vector2D(this.velocity.x-5,0));
			drill1.rotationZ=180;
			if (stage) stage.addChild(drill1);
		}
	}
	
}