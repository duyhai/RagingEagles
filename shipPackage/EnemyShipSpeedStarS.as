package shipPackage{
	
	import shipPackage.bulletPackage.*;
	import enumPackage.*;
	
	import flash.events.Event;
	
	public class EnemyShipSpeedStarS extends EnemyShipX22Fighter{	//ehhez még kell lövedék-kerülgetés
		
		var fuel:Number=120;
		
		public function EnemyShipSpeedStarS(firerate:Number = EnumFireRate.LEVEL_THREE, health:Number = EnumHealth.LEVEL_TWO, pos:Vector2D=null, velocity:Vector2D = null) {
			super(firerate, health, pos, velocity);
			bulletdamage=EnumDamage.LEVEL_FOUR;
			maxspeedx=EnumSpeed.LEVEL_FIVE;
			maxspeedy=EnumSpeed.LEVEL_FIVE;
		}
		
		override protected function enterFrame(e:Event)
		{
			var vy:Number=0;	//egyelőre ezt a függvényt sikerült kikísérletezni, még finomhangolom 
				//hogy ne rángatózzanak a hajók, meg ne akarjanak kimenni a képből
			//így nagyjából lézer meg nem lézer elől is kitér
			for(var i in Bullet.hero_bullet_list)
			{
				if (Bullet.hero_bullet_list[i].x<this.x)
					velocity.y+=Math.abs(this.y-stage.stageHeight/2)/(Bullet.hero_bullet_list[i].y-this.y)*(Bullet.hero_bullet_list[i].x-this.x)/this.x*1;
			}
			velocity.y+=(stage.stageHeight/2-this.y)/50;
			velocity.y=(velocity.y*0.9+vy*0.1);
			var temp:Number=velocity.y;	//azért nem szorzom meg minden körben a velocity.y-t a fuel/100-zal,
									//mert akkor exponenciálisan csökkene az sbesség, nem lineárisan
			velocity.y*=fuel/100;
			super.enterFrame(e);
			velocity.y=temp;
		}
		
		override protected function shoot(){
			if (stage) stage.addChild(new LaserBlast(false, bulletdamage+damagebonus, new Vector2D(this.x-30, this.y+13), new Vector2D(-10+velocity.x,0)));
		}
	}
	
}