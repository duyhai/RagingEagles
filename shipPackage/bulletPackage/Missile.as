package shipPackage.bulletPackage
{
	import shipPackage.*;
	import menuPackage.*;
	import flash.events.Event;
	import flash.display.MovieClip;
	import soundPackage.SoundMaster;
	
	public class Missile extends Bullet
	{	 
		 var lifespan:Number;
		 var maxrange:Number=100;
		
		 public function Missile(ishero: Boolean=true, dmg:Number=10, ls:Number=60, pos:Vector2D=null, velocity:Vector2D = null)
		 {			 
			 super(ishero, dmg, pos, velocity);
			 lifespan=ls;
			 maxrange+=10*TalentMenu.Instance(stage).GetSpecTalent().GetTalent(0);
			 killed = false;
			 SoundMaster.PlayRocketShotSound();
		 }
		 
		 override protected function enterFrame(e:Event)
		 {
			 super.enterFrame(e);
			 lifespan--;
			 if (lifespan<=0 && !killed) kill();
		 }
		 
		 override public function kill(){
			 if (killed) return;
			 var distance:Number;
			 var coeff:Number;
			 if (isHero)
			 {
				 for each (var ESh:EnemyShip in EnemyShip.list){	//egy körben több hajó is meghalhat (ilyenkor az indexelés megváltozik a listán belül), ezért kell a foreach
					distance = new Vector2D(ESh.x-this.x, ESh.y-this.y).length();
					coeff = 1/((100+distance)/100*(100+distance)/100);	//négyzetes csökkenés
					coeff*=(5-TalentMenu.Instance(stage).GetSpecTalent().GetTalent(1))/5;
					if (distance<=maxrange)
						ESh.takeDamage(damage*coeff);	//akinek neki is ütközi azt duplán sebzi*/
				 }
			 }
			 else
			 {
			  	distance = new Vector2D(GameClass.heroShip.x-this.x, GameClass.heroShip.y-this.y).length();
				coeff = 1/((100+distance)/100*(100+distance)/100);	//négyzetes csökkenés
				if (distance<=maxrange)
					GameClass.heroShip.takeDamage(damage*coeff);
			 }
			 super.kill();
		 }
		 
		 override public function giveDamage(target:MovieClip):Number
		 {
			this.kill();
			return damage;
		 }
		 
	}
}