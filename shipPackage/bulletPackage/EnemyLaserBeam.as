package shipPackage.bulletPackage
{
    import shipPackage.*;
	import menuPackage.*;
    import flash.events.Event;
    import flash.display.MovieClip;
    import effectPackage.SmokePuff;
      
    public class EnemyLaserBeam extends Bullet{
                    
		var firerate: Number; //Másodpercenkénti sebzés száma.
		var shipPos: MovieClip //Referencia a hajó pozíciójára
		
        public function EnemyLaserBeam(shipPos:MovieClip, firerate:Number = 5, dmg:Number = 10, pos:Vector2D = null, velocity:Vector2D = null){
            super(false, dmg, pos, velocity);
			this.firerate = firerate;
			this.shipPos = shipPos;
			this.height=5;
        }
        
		protected function setPos(){
			x = shipPos.x-25;
			y = shipPos.y+10;
		}
		
        override protected function enterFrame(e:Event){
						
			setPos();

			destination.x=0;
			destination.y=this.y;
			this.width=(this.x-destination.x);
			
			if(this.hitTestObject(GameClass.heroShip)){
				if((GameClass.heroShip.x > destination.x)&&(GameClass.heroShip.x<this.x)){
					setDestination(new Vector2D(GameClass.heroShip.x, this.y));
					GameClass.heroShip.takeDamage(giveDamage(GameClass.heroShip));
					if(stage) stage.addChild(new SmokePuff(GameClass.heroShip.x, this.y));
				}
			}

			this.width=(destination.x-this.x);			
        }
          
        override public function kill()
        {
            removeEventListener("enterFrame", enterFrame);   
            stage.removeChild(this);    //szerintem itt kéne remove-olni a bullet_list-bol is, de ezt még majd átgondolom
            for(var i in hero_bullet_list)   //Kell. shootorialban is igy volt.
                    if(hero_bullet_list[i] == this)
                        delete hero_bullet_list[i];
        }
          
    }
      
}