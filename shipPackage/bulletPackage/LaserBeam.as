package shipPackage.bulletPackage
{
    import shipPackage.*;
	import menuPackage.*;
    import flash.events.Event;
    import flash.display.MovieClip;
    import effectPackage.SmokePuff;
	import soundPackage.SoundMaster;
      
    public class LaserBeam extends Bullet{	//ha EnemyShip is akarja használni akkor majd kicsit változtatni kell rajta
                    
		//A pozíció koordinátája  az objektum bal szélén lesz!! Tehát a num padot nézve a 4-es pontban.
		var firerate: Number; //Másodpercenkénti sebzés száma.
		var heroShipPos: MovieClip //Referencia a hajó pozíciójára
		var spawnLaser:LaserBeam2 = null //NightmareBeam esetén ez a referencia mutat a vékonyabb sugárra
		
        public function LaserBeam(heroShipPos:MovieClip, firerate:Number = 5, dmg:Number = 10, pos:Vector2D = null, velocity:Vector2D = null){
			dmg*=(1+0.05*TalentMenu.Instance(stage).GetSpecTalent().GetTalent(1));	//szerintem ez itt jobb megolds mint az attack rate
            super(true, dmg, pos, velocity);
			this.firerate = firerate;
			this.heroShipPos = heroShipPos;
			this.height=15*(1+0.2*TalentMenu.Instance(stage).GetSpecTalent().GetTalent(0));
        }
        
		protected function setPos(){
			x = heroShipPos.x+44;
			y = heroShipPos.y+10;
		}
		
        override protected function enterFrame(e:Event){
				
			//SoundMaster.PlayLaserBeamSound();
			setPos();
			
			var temp:EnemyShip = null;
			
			//Search closest enemyship.	
			destination.x=stage.stageWidth;
			destination.y=this.y;
			this.width=(destination.x-this.x);
			for(var i in EnemyShip.list){
			
				if(this.hitTestObject(EnemyShip.list[i])){
				
					if((EnemyShip.list[i].x < destination.x)&&(EnemyShip.list[i].x>this.x)){	//destination.x>this.x-nél az egyenlőség nem megengedett, ez majd hasznos lesz annál				
					//a fejlesztésnél amikor a lézer átüti a hajókat
						setDestination(new Vector2D(EnemyShip.list[i].x, this.y));
						temp = EnemyShip.list[i];
						
					}
				
				}
			
			}

			this.width=(destination.x-this.x);
			
			//Damage enemy
			if (temp) 
			{
				if (TalentMenu.Instance(stage).GetSpecTalent().GetTalent(2)>0) temp.takeDamage(giveDamage(temp),"PlasmaBlast");
				else temp.takeDamage(giveDamage(temp));
				if (TalentMenu.Instance(stage).GetSpecTalent().GetTalent(3)>0 && !spawnLaser)	//NightmareBeam
				{
					if (TalentMenu.Instance(stage).GetSpecTalent().GetTalent(3)>0)
						spawnLaser = new NightMareLaserBeam2(this, 0, this.damage/2, new Vector2D(destination.x+1,destination.y), new Vector2D(0,0));
					else
						spawnLaser = new LaserBeam2(this, 0, this.damage/2, new Vector2D(destination.x+1,destination.y), new Vector2D(0,0));
					spawnLaser.height=this.height/2;
					stage.addChild(spawnLaser);
				}
				stage.addChild(new SmokePuff(destination.x+1,destination.y));
			}
			
        }
          
        override public function kill()
        {
            removeEventListener("enterFrame", enterFrame);   
            stage.removeChild(this);    //szerintem itt kéne remove-olni a bullet_list-bol is, de ezt még majd átgondolom
            for(var i in hero_bullet_list)   //Kell. shootorialban is igy volt.
                    if(hero_bullet_list[i] == this)
                        delete hero_bullet_list[i];
			if (spawnLaser) spawnLaser.kill();
			spawnLaser=null;
        }
          
    }
      
}