package shipPackage{
	
	import enumPackage.*;
	import flash.events.Event;
	
	public class EnemyShipRemnantCube extends EnemyShip{
		
		public function EnemyShipRemnantCube(firerate:Number = 0, health:Number = EnumHealth.LEVEL_TWO, pos:Vector2D=null, velocity:Vector2D = null)
		{
			super(firerate,health,pos,velocity);
			bulletdamage=0;
			maxspeedx=EnumSpeed.LEVEL_ONE;
			maxspeedy=EnumSpeed.LEVEL_ONE;
		}
		
		override protected function enterFrame(e:Event)
		{
			this.rotationZ-=1;
			super.enterFrame(e);
		}
		
		override public function kill()
		{
			if (killed) return;
			if (x<-50)	//különben ha 2 remnantcube kb. egyszerre éri el a -100-at akkor végtelenszer megsemmisülnek és újrateremtődnek egymás mellett, ami lassú
			{
				super.kill();
				killed=true;
				return;
			}
			var nearest:EnemyShip=null;
			var distance:Number=10000;
			for(var i in EnemyShip.list)
			{
				var d:Number = new Vector2D(EnemyShip.list[i].x-this.x,EnemyShip.list[i].y-this.y).length();
				if (d<distance && EnemyShip.list[i]!=this)
				{
					distance = d;
					nearest = EnemyShip.list[i];
				}
			}
			if (nearest)
			{
				var clone:EnemyShip=null;
				if (nearest is EnemyShipExecutioner9000) clone = new EnemyShipExecutioner9000(0,EnumHealth.LEVEL_FOUR*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipMeltdownZero) clone = new EnemyShipMeltdownZero(EnumFireRate.LEVEL_FIVE*1.25,EnumHealth.LEVEL_THREE*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipChitinA) clone = new EnemyShipChitinA(EnumFireRate.LEVEL_THREE*1.25,EnumHealth.LEVEL_FIVE*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipChitinB) clone = new EnemyShipChitinB(EnumFireRate.LEVEL_FOUR*1.25,EnumHealth.LEVEL_FOUR*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipHunterRAVEN) clone = new EnemyShipHunterRAVEN(EnumFireRate.LEVEL_THREE*1.25,EnumHealth.LEVEL_THREE*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipAlphaFighter) clone = new EnemyShipAlphaFighter(EnumFireRate.LEVEL_THREE*1.25,EnumHealth.LEVEL_THREE*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipOmegaFighter) clone = new EnemyShipOmegaFighter(EnumFireRate.LEVEL_THREE*1.25,EnumHealth.LEVEL_THREE*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipStinger) clone = new EnemyShipStinger(EnumFireRate.LEVEL_FOUR*1.25,EnumHealth.LEVEL_THREE*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipWarpCannonBeta) clone = new EnemyShipWarpCannonBeta(EnumFireRate.LEVEL_TWO*1.25,EnumHealth.LEVEL_THREE*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipShockblast) clone = new EnemyShipShockblast(EnumFireRate.LEVEL_THREE*1.25,EnumHealth.LEVEL_TWO*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipSpeedStarS) clone = new EnemyShipSpeedStarS(EnumFireRate.LEVEL_THREE*1.25,EnumHealth.LEVEL_TWO*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipOverlord) clone = new EnemyShipOverlord(0,EnumHealth.LEVEL_THREE*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipMegaDrillBeta) clone = new EnemyShipMegaDrillBeta(EnumFireRate.LEVEL_THREE*1.25, EnumHealth.LEVEL_FIVE*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipRemnantCube) clone = new EnemyShipRemnantCube(0, EnumHealth.LEVEL_TWO*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*2-1));
				else if (nearest is EnemyShipX22Fighter) clone = new EnemyShipX22Fighter(EnumFireRate.LEVEL_THREE*1.25,EnumHealth.LEVEL_THREE*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*5-2));
				else if (nearest is EnemyShipX22Commander) clone = new EnemyShipX22Commander(EnumFireRate.LEVEL_THREE*1.25,EnumHealth.LEVEL_FOUR*1.25,new Vector2D(this.x, this.y), new Vector2D(-Math.random()*5-10,Math.random()*5-2));
				if (clone) 
				{
					clone.grayscale();
					stage.addChild(clone);
				}
			}
			super.kill();
			killed=true;
		}
		
			
	}
	
}