package{
	
	import shipPackage.*;
	import shipPackage.bossPackage.*;
	import menuPackage.*;
	import enumPackage.*;
	import background.*;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import soundPackage.SoundMaster;
	
	public class GameClass extends BaseMenu{
		
		static var instance:GameClass = null;
		public static var heroShip: HeroShip;
		static var heroType: Number;
		public static var HPBar: HeroHPBar;
		static var sendEnemy: Function;
		public static var DaBossHPBar:BossHPBar;
		static var temp: Function;//<--- FUCK
		
		var timer01:Timer;
		var wave:Number = 0;
		var initwave:Boolean=true;
		var wavefinished:Boolean = false;
		var Background:BackgroundClass;
		
		public function GameClass(stageRef:Stage=null){
			super(stageRef, "Game");
			
			this.stageRef.addChild(this);
			this.addEventListener("enterFrame", enterFrame);
			
			//-------------------------------
			
			SelectHero(heroType);
			Background = new BackgroundClass(stageRef);
			heroShip.x=600;
			heroShip.y=600;
			this.stageRef.addChild(heroShip);
			this.stageRef.addChild(HPBar);
			
			/*this.stageRef.addChild(new EnemyShip(10,10,new Vector2D(300,225), new Vector2D(0,0)));
			this.stageRef.addChild(new EnemyShip(10,10,new Vector2D(400,225), new Vector2D(0,0)));
			this.stageRef.addChild(new EnemyShip(10,10,new Vector2D(500,225), new Vector2D(0,0)));
			*/
			Mouse.hide();
			this.stageRef.addEventListener("mouseDown", heroShip.MouseDown);
			this.stageRef.addEventListener("mouseUp", heroShip.MouseUp);
			this.stageRef.addEventListener(MouseEvent.MOUSE_WHEEL, onMidClick);
			TalentMenu.Instance(stageRef);
			
			if (Engine.so.data.wave == null)
			{	
				sendEnemy=firstWave;
			}
			else
			{
				wave=Engine.so.data.wave;
				switch(wave)
				{
					case 0:
					{
						sendEnemy=firstWave;
						break;
					}
					case 1:
					{
						sendEnemy=secondWave;
						break;
					}
					case 2:
					{
						sendEnemy=thirdWave;
						break;
					}
					case 3:
					{
						sendEnemy=fourthWave;
						break;
					}
					case 4:
					{
						sendEnemy=fifthWave;
						break;
					}
					case 5:
					{
						sendEnemy=sixthWave;
						break;
					}
					case 6:
					{
						sendEnemy=seventhWave;
						break;
					}
					case 7:
					{
						sendEnemy=eighthWave;
						break;
					}
					case 8:
					{
						sendEnemy=ninthWave;
						break;
					}
					case 9:
					{
						sendEnemy=tenthWave;
						break;
					}
				}
				sendEnemy=firstWave;
			}
			//-------------------------------
		}
				
		private function enterFrame(e: Event){
			
			sendEnemy();
			
		}
		
		private function initWave(time:Number)
		{
			heroShip.bringToFront();
			HPBar.bringToFront();
			for (var i in EnemyShip.list)
			{
				EnemyShip.list[i].bringToFront();
			}
			initwave=false;
			timer01 = new Timer(time,100);
			timer01.addEventListener(TimerEvent.TIMER,onTimer);
			timer01.start();
		}
		
		private function onTimer(event:TimerEvent)
		{
			timer01.stop();
			if(EnemyShip.list.length == 0){
				timer01.removeEventListener(TimerEvent.TIMER,onTimer);
				wavefinished = true;
			}
		}
		
		private function nextWave(nextwave:Number, f:Function)
		{
			wave=nextwave;
			Engine.so.data.wave=wave;
			initwave=true;
			wavefinished=false;
			sendEnemy=f;
		}
		
		
		//------------Waves-------------------		
		//külön osztályba kéne rakni őket
		private function nothing()
		{
			var R:Number = Math.random()*100;
			if (R<8)
			{
				this.stageRef.addChild(new EnemyShipMegaDrillBeta(EnumFireRate.LEVEL_THREE, EnumHealth.LEVEL_FIVE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
		}
		

		private function firstWave(){
			if (initwave) 
			{
				Background.newBackground(new Array(new Background01_01(),new Background01_02()));
				Background.setSpeeds(new Array(0.1,2));
				initWave(10000);
			}
			
			if (!wavefinished)
			{
				var R:Number = Math.random()*100;
				if (R<2)
				{
					this.stageRef.addChild(new EnemyShipX22Commander(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
				if (R<8)
				{
					this.stageRef.addChild(new EnemyShipX22Fighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
				else if (R<16)
				{
					this.stageRef.addChild(new EnemyShipSpeedStarS/*X22Commander*/(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
			}
			
			if (wavefinished && (EnemyShip.numOfShips==0))
			{
				Background.killBackground();
				//nextWave(wave+1, secondWave);
				unload(TalentMenu.Instance(stageRef));
			}
		}
		
		private function secondWave(){
			if (initwave)
			{
				Background.newBackground(new Array(new Background02_01(),new Background02_02()));
				Background.setSpeeds(new Array(0.1,2));
				initWave(10000);
			}
			
			if (!wavefinished)
			{
				var R:Number = Math.random()*100;
				if (R<8)
				{
					this.stageRef.addChild(new EnemyShipExecutioner9000(0,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
				}
				else if (R<11)
				{
					this.stageRef.addChild(new EnemyShipMeltdownZero(EnumFireRate.LEVEL_FIVE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
				}
			}
			
			if (wavefinished  && (EnemyShip.numOfShips==0))
			{
				Background.killBackground();
				//nextWave(wave+1, thirdWave);
				unload(TalentMenu.Instance(stageRef));
			}
		}
		
		private function thirdWave(){
			if (initwave) 
			{
				Background.newBackground(new Array(new Background03_01(),new Background03_02()));
				Background.setSpeeds(new Array(0.1,2));
				initWave(10000);
			}
			
			if (!wavefinished)
			{
				var R:Number = Math.random()*100;
				if (R<8)
				{
					this.stageRef.addChild(new EnemyShipX22Fighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
				else if (R<16)
				{
					this.stageRef.addChild(new EnemyShipSpeedStarS/*X22Commander*/(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
			}
			
			if (wavefinished && (EnemyShip.numOfShips==0))
			{
				Background.killBackground();
				//nextWave(wave+1, secondWave);
				unload(TalentMenu.Instance(stageRef));
			}
		}
		
		private function fourthWave(){
			if (initwave)
			{
				Background.newBackground(new Array(new Background04_01(),new Background04_02()));
				Background.setSpeeds(new Array(0.1,2));
				initWave(10000);
			}
			
			if (!wavefinished)
			{
				var R:Number = Math.random()*100;
				if (R<8)
				{
					this.stageRef.addChild(new EnemyShipMegaDrillBeta(EnumFireRate.LEVEL_THREE, EnumHealth.LEVEL_FIVE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
				}
				else if (R<11)
				{
					this.stageRef.addChild(new EnemyShipRemnantCube(0, EnumHealth.LEVEL_TWO,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
				}
			}
			
			if (wavefinished  && (EnemyShip.numOfShips==0))
			{
				Background.killBackground();
				//nextWave(wave-1, secondWave);				
				unload(TalentMenu.Instance(stageRef));
			}
		}
		
		private function fifthWave(){
			if (initwave) 
			{
				Background.newBackground(new Array(new Background05_01(),new Background05_02()));
				Background.setSpeeds(new Array(0.1,2));
				initWave(10000);
			}
			
			if (!wavefinished)
			{
				var R:Number = Math.random()*100;
				if (R<8)
				{
					this.stageRef.addChild(new EnemyShipX22Fighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
				else if (R<16)
				{
					this.stageRef.addChild(new EnemyShipSpeedStarS/*X22Commander*/(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
			}
			
			if (wavefinished  && (EnemyShip.numOfShips==0))
			{
				Background.killBackground();
				//nextWave(wave+1, secondWave);
				unload(TalentMenu.Instance(stageRef));
			}
		}
		
		private function sixthWave(){
			if (initwave) 
			{
				Background.newBackground(new Array(new Background06_01()));
				Background.setSpeeds(new Array(0.1,2));
				initWave(10000);
			}
			
			if (!wavefinished)
			{
				var R:Number = Math.random()*100;
				if (R<8)
				{
					this.stageRef.addChild(new EnemyShipX22Fighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
				else if (R<16)
				{
					this.stageRef.addChild(new EnemyShipSpeedStarS/*X22Commander*/(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
			}
			
			if (wavefinished  && (EnemyShip.numOfShips==0))
			{
				Background.killBackground();
				//nextWave(wave+1, secondWave);
				unload(TalentMenu.Instance(stageRef));
			}
		}
		
		private function seventhWave(){
			if (initwave) 
			{
				Background.newBackground(new Array(new Background07_02(),new Background07_01()));
				Background.setSpeeds(new Array(0.1,2));
				initWave(10000);
			}
			
			if (!wavefinished)
			{
				var R:Number = Math.random()*100;
				if (R<8)
				{
					this.stageRef.addChild(new EnemyShipX22Fighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
				else if (R<16)
				{
					this.stageRef.addChild(new EnemyShipSpeedStarS/*X22Commander*/(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
			}
			
			if (wavefinished  && (EnemyShip.numOfShips==0))
			{
				Background.killBackground();
				//nextWave(wave+1, secondWave);
				unload(TalentMenu.Instance(stageRef));
			}
		}
		
		private function eighthWave(){
			if (initwave) 
			{
				Background.newBackground(new Array(new Background08_01(),new Background08_02()));
				Background.setSpeeds(new Array(0.1,2));
				initWave(10000);
			}
			
			if (!wavefinished)
			{
				var R:Number = Math.random()*100;
				if (R<8)
				{
					this.stageRef.addChild(new EnemyShipX22Fighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
				else if (R<16)
				{
					this.stageRef.addChild(new EnemyShipSpeedStarS/*X22Commander*/(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
			}
			
			if (wavefinished  && (EnemyShip.numOfShips==0))
			{
				Background.killBackground();
				//nextWave(wave+1, secondWave);
				unload(TalentMenu.Instance(stageRef));
			}
		}
		
		private function ninthWave(){
			if (initwave) 
			{
				Background.newBackground(new Array(new Background09_01(),new Background09_02(),new Background09_03(),new Background09_04()));
				Background.setSpeeds(new Array(0.1,0.5,1,2));
				initWave(10000);
			}
			
			if (!wavefinished)
			{
				var R:Number = Math.random()*100;
				if (R<8)
				{
					this.stageRef.addChild(new EnemyShipX22Fighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
				else if (R<16)
				{
					this.stageRef.addChild(new EnemyShipSpeedStarS/*X22Commander*/(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
			}
			
			if (wavefinished  && (EnemyShip.numOfShips==0))
			{
				Background.killBackground();
				//nextWave(wave+1, secondWave);
				unload(TalentMenu.Instance(stageRef));
			}
		}
		
		private function tenthWave(){
			if (initwave) 
			{
				Background.newBackground(new Array(new Background10_01()));
				Background.setSpeeds(new Array(0.1,2));
				initWave(10000);
			}
			
			if (!wavefinished)
			{
				var R:Number = Math.random()*100;
				if (R<8)
				{
					this.stageRef.addChild(new EnemyShipX22Fighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
				else if (R<16)
				{
					this.stageRef.addChild(new EnemyShipSpeedStarS/*X22Commander*/(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
				}
			}
			
			if (wavefinished  && (EnemyShip.numOfShips==0))
			{
				Background.killBackground();
				//nextWave(wave+1, secondWave);
				unload(TalentMenu.Instance(stageRef));
			}
		}
		
		private function sendEverything(){
			var R:Number = Math.random()*100;
			/*if (R<8)
			{
				this.stageRef.addChild(new EnemyShipX22Fighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
			}
			else if (R<11)
			{
				this.stageRef.addChild(new EnemyShipX22Commander(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*5-2)));
			}
			else if (R<14)
			{
				this.stageRef.addChild(new EnemyShipExecutioner9000(0,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<18)
			{
				this.stageRef.addChild(new EnemyShipMeltdownZero(EnumFireRate.LEVEL_FIVE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<22)
			{
				this.stageRef.addChild(new EnemyShipChitinA(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_FIVE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<26)
			{
				this.stageRef.addChild(new EnemyShipChitinB(EnumFireRate.LEVEL_FOUR,EnumHealth.LEVEL_FOUR,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<27)
			{
				this.stageRef.addChild(new EnemyShipHunterRAVEN(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<28)
			{
				this.stageRef.addChild(new EnemyShipAlphaFighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<30)
			{
				this.stageRef.addChild(new EnemyShipOmegaFighter(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<10)
			{
				this.stageRef.addChild(new EnemyShipStinger(EnumFireRate.LEVEL_FOUR,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<15)
			{
				this.stageRef.addChild(new EnemyShipWarpCannonBeta(EnumFireRate.LEVEL_TWO,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<20)
			{
				this.stageRef.addChild(new EnemyShipShockblast(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_TWO,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else */if (R>20)if (R<26)
			{
				this.stageRef.addChild(new EnemyShipSpeedStarS(EnumFireRate.LEVEL_THREE,EnumHealth.LEVEL_TWO,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<26.1)
			{
				this.stageRef.addChild(new EnemyShipOverlord(0,EnumHealth.LEVEL_THREE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<28)
			{
				this.stageRef.addChild(new EnemyShipMegaDrillBeta(EnumFireRate.LEVEL_THREE, EnumHealth.LEVEL_FIVE,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
			else if (R<32)
			{	
				this.stageRef.addChild(new EnemyShipRemnantCube(0, EnumHealth.LEVEL_TWO,new Vector2D(900,Math.random()*400+25), new Vector2D(-Math.random()*5-10,Math.random()*2-1)));
			}
		}
		//---------------------------------
		
		private function onMidClick(e: MouseEvent)
		{
			unload(TalentMenu.Instance(stageRef));
		}
		
		public static function SelectHero(type: Number): void{
			
			heroType = type;
			Engine.so.data.heroType = heroType;
			
			switch(type){
				
				case 0: heroShip = new Driller(); HPBar = new DrillerHPBar(); break;
				case 1: heroShip = new LaserShip(); HPBar = new LaserHPBar(); break;
				case 2: heroShip = new RocketShip(); HPBar = new RocketHPBar(); break;
				default: break;
				
			}
			
		}
		
		public static function Instance(stageRef:Stage=null):GameClass
		{
			if(instance == null)
			{
				//allowCallConstructor = true;
				instance = new GameClass(stageRef);
				//allowCallConstructor = false;
			}
			return instance;
		}
		
		public static function setHeroType(n:Number): void
		{
			heroType = n;
		}
		
		public static function getHeroType():Number
		{
			return heroType;
		}
		
		override public function load(): void
		{
			super.load();
			Mouse.hide();
			
			//if (wave+1>=3) unload(MainMenu.Instance(stageRef));
			//else
			switch((wave+1) %10)
				{
					case 0:
					{
						temp=firstWave;
						break;
					}
					case 1:
					{
						temp=secondWave;
						break;
					}
					case 2:
					{
						temp=thirdWave;
						break;
					}
					case 3:
					{
						temp=fourthWave;
						break;
					}
					case 4:
					{
						temp=fifthWave;
						break;
					}
					case 5:
					{
						temp=sixthWave;
						break;
					}
					case 6:
					{
						temp=seventhWave;
						break;
					}
					case 7:
					{
						temp=eighthWave;
						break;
					}
					case 8:
					{
						temp=ninthWave;
						break;
					}
					case 9:
					{
						temp=tenthWave;
						break;
					}
				}
			nextWave(wave+1, temp);
		}
		
		override public function unload(loadMe:BaseMenu = null) : void
		{
			SoundMaster.StopAllSounds();
			Mouse.show();
			super.unload(loadMe);
		}
	}
}