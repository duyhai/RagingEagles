package shipPackage.bulletPackage
{
	import shipPackage.*;
	import menuPackage.*;
	import flash.events.Event;
	import flash.display.MovieClip;
	import soundPackage.SoundMaster;
	
	public class HomingMissile extends Bullet
	{	 
		 var lifespan:Number;
		 var maxrange:Number=100;
		 var target:Ship=null;
		 var speed:Number;
		 var turning:Number = 5;
		 
		 public function HomingMissile(ishero:Boolean=true, dmg:Number=10, ls:Number=60, pos:Vector2D=null, velocity:Vector2D = null)
		 {			 
			 super(ishero, dmg, pos, velocity);
			 lifespan=ls;
			 if (ishero) maxrange+=10*TalentMenu.Instance(stage).GetSpecTalent().GetTalent(0);
			 speed = velocity.length();
			 
			 /*if (!(EnemyShip.list.isEmpty))	//Ezt azért nem töröltem mert ki kell elemezni hogy pontosan miért nem működik
			 {
			 	target = EnemyShip.list[20];
				trace(target);
			 	for(var i in EnemyShip.list)
				{trace(EnemyShip.list[i]);
				trace(EnemyShip.list.indexOf(EnemyShip.list[i]));
				 	if (targetFitness(EnemyShip.list[i])>targetFitness(target))
						target = EnemyShip.list[i];
			 	}
				for each(var eSh:EnemyShip in EnemyShip.list)
				if (eSh!=null){
				 	if (targetFitness(eSh)>targetFitness(target))
						target = eSh;
			 	}
			 }*/
			 if (ishero) target=findTarget();
			 else target = GameClass.heroShip;
			 SoundMaster.PlayRocketShotSound();
		 }
		 
		 public function targetFitness(eSh:EnemyShip):Number	//melyik ellenfelet a legkönnyebb eltalálni
		 {	 
		 	 var xval:Number;
		 	 var yval:Number;
			 if (eSh.x>900||eSh.x<-100) xval=10000;	//ez a konstruktorban fut, és ott még stage==null, tehát nem elérhető a stage.stageWidth
			 else if (eSh.getVelocity().x<1 && eSh.getVelocity().x>-1) xval=0.0001;
			 else
			 {
				 xval=Math.abs((eSh.x-this.x)/eSh.getVelocity().x);
			 }
			 if (eSh.y>900||eSh.y<-100) yval=10000;	//ez a konstruktorban fut, és ott még stage==null, tehát nem elérhető a stage.stageWidth
			 else if (eSh.getVelocity().y<1 && eSh.getVelocity().y>-1) yval=0.0001;
			 else
			 {
				 yval=Math.abs((eSh.y-this.y)/eSh.getVelocity().y);
			 }
			 return xval+yval;	//Manhattan-távolság
		 }
		 
		 protected function findTarget():EnemyShip
		 {
			 var t:EnemyShip=null;
			 var bestFitness:Number=10000;
			 for each (var ESh:EnemyShip in EnemyShip.list){
				 if(targetFitness(ESh)<bestFitness){
					 t=ESh;
					 bestFitness=targetFitness(ESh);
				 }
			 }
			 return t;
		 }
		 
		 override protected function enterFrame(e:Event)
		 { 	
		 	if (isHero) target=findTarget();
		 	else target=GameClass.heroShip;
			if(target)
			{
				var angle:Number = Math.atan2(target.y-this.y,target.x-this.x)/Math.PI*180;
				if (Math.abs(rotationZ-angle)%360<=turning) rotationZ=angle;
				else
				{
					if (angle>rotationZ)
					{
						if (angle-rotationZ<180) rotationZ+=turning;
						else rotationZ-=turning;
					}
					else
					{
						if (rotationZ-angle<180) rotationZ-=turning;
						else rotationZ+=turning;
					}
				}
				velocity.x=speed*Math.cos(rotationZ*Math.PI/180);
				velocity.y=speed*Math.sin(rotationZ*Math.PI/180);
 			}
			x+=velocity.x;
			y+=velocity.y;
				
			if(x > 1000 || x < -100 || y > 550 || y < -100)
				kill();
			else
			{
				if (isHero)
				{
					for(var i in EnemyShip.list){
						if(this.hitTestObject(EnemyShip.list[i])){
							EnemyShip.list[i].takeDamage(this.giveDamage(EnemyShip.list[i]));
						}
					}
				}
				else
				{
					if(this.hitTestObject(GameClass.heroShip)){
							GameClass.heroShip.takeDamage(this.giveDamage(GameClass.heroShip));
						}
				}
			}
			 lifespan--;
			// if (lifespan<=0 && !killed) kill();
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