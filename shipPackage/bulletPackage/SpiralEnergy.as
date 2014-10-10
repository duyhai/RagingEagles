package shipPackage.bulletPackage
{
	import shipPackage.*;
	import flash.events.Event;
	
	public class SpiralEnergy extends Bullet	//ha EnemyShip is akarja használni akkor majd kicsit változtatni kell rajta
	{	 
		 var killed:Boolean=false;	//hogy egy körben csak egyszer lehessen meghalni
		 var heroShipPos: MovieClip
		 
		 public function HomingMissile(heroShipPos:MovieClip, dmg:Number=10, ls:Number=60, pos:Vector2D=null, velocity:Vector2D = null)
		 {
			 super(true, dmg, pos, velocity);
			 this.heroShipPos=heroShipPos;
		 }
		 
		 override protected function enterFrame(e:Event){
			//Set position according to heroship position.
			//pos.copyFrom(heroShipPos);
			x = heroShipPos.x+heroShipPos.width;
			y = heroShipPos.y;
			if(x > 1000 || x < -100 || y > 550 || y < -100)
				kill();
			for(var i in EnemyShip.list){
				if(this.hitTestObject(EnemyShip.list[i])){
					EnemyShip.list[i].takeDamage(this.giveDamage(EnemyShip.list[i]));
				}
			}
			for(var i in Bullet.enemy_bullet_list){
				if(this.hitTestObject(Bullet.enemy_bullet_list[i])){
					heroShip.takeDamage(this.giveDamage(heroShip)/2);
				}
			}
		}
		
		 
	}
}