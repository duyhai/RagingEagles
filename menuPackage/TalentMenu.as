package menuPackage
{
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import soundPackage.SoundMaster;
	
	public class TalentMenu extends BaseMenu
	{
		//Singleton model
		private static var instance:TalentMenu = null;
		private static var allowCallConstructor:Boolean = false;
				
		//Leveling infos		
		private var expPoints:Number = 0; //Current experience points
		private var nextLevel:Number = 100; //Number of exp points needed to level up.
		private var currentLevel:Number = 0; //Current level

		//Talent infos
		private var talentPoints:Number = 0; //Spendable talent points
		private var berserkTalent:BerserkTalent;
		private var techTalent:TechTalent;
		private var specTalent:Talent;

		public function TalentMenu(stageRef:Stage = null) 
		{
			super(stageRef, "TalentMenu");
			
			//Loading saved data
			if (Engine.so.data.hasSavedData!=undefined)
			{
				expPoints = Engine.so.data.expPoints;
				nextLevel = Engine.so.data.nextLevel;
				currentLevel = Engine.so.data.currentLevel;
				talentPoints = Engine.so.data.talentPoints;
			}
			berserkTalent = new BerserkTalent();
			techTalent = new TechTalent();
			switch(GameClass.getHeroType())
			{
				case 0: specTalent = new DrillTalent(); break;
				case 1: specTalent = new LaserTalent(); break;
				case 2: specTalent = new RocketTalent(); break;
			}			
				
			
			//Buttons init
			btnStart.TextGlow.alpha = 0;
 			btnStart.ButtonGlow.alpha = 0;
			btnStart.Text.text = "Start";
			btnStart.TextGlow.Text.text = "Start";
			btnQuit.TextGlow.alpha = 0;
 			btnQuit.ButtonGlow.alpha = 0;
			btnQuit.Text.text = "Quit";
			btnQuit.TextGlow.Text.text = "Quit";
		}

		override protected function buttonsActivate(): void
		{			
			//Due to weak reference, removal the listeners will not be necessary
			btnStart.addEventListener(MouseEvent.CLICK, startClick, false, 0, true);
			btnStart.addEventListener(MouseEvent.MOUSE_OVER, Select, false, 0, true);
			btnStart.addEventListener(MouseEvent.MOUSE_OUT, DeSelect, false, 0, true);
			btnQuit.addEventListener(MouseEvent.CLICK, quitClick, false, 0, true);
			btnQuit.addEventListener(MouseEvent.MOUSE_OVER, Select, false, 0, true);
			btnQuit.addEventListener(MouseEvent.MOUSE_OUT, DeSelect, false, 0, true);
		}		

		private function startClick(e:MouseEvent) : void
		{
			SoundMaster.StopAllSounds();
			unload(GameClass.Instance(stageRef));
		}
		
		private function quitClick(e:MouseEvent) : void
		{
 			//debug
			GainExp(50);
			
			textLevel.text = String(currentLevel);
			textXP.text = String(expPoints + "/" + nextLevel);
			textTalentPoints.text = String("talent points: " + talentPoints);
			//unload(new MainMenu(stageRef));
		}
		
		//Hovering over a button
		private function Select(e:MouseEvent) : void
		{
 			e.currentTarget.TextGlow.alpha = 1;
 			e.currentTarget.ButtonGlow.alpha = 1;
		}
 
		//Unhovering from a button
		private function DeSelect(e:MouseEvent) : void
		{
 			e.currentTarget.TextGlow.alpha = 0;
 			e.currentTarget.ButtonGlow.alpha = 0;
		}
		
		override public function load(): void
		{
			super.load();
			
			textLevel.text = String(currentLevel);
			textXP.text = String(expPoints + "/" + nextLevel);
			textTalentPoints.text = String("talent points: " + talentPoints);
						
			berserkTalent.visible=true;
			techTalent.visible=true;
			specTalent.visible=true;
			
			berserkTalent.x = 200;
			berserkTalent.y = 0;
			techTalent.x = 400;
			techTalent.y = 0;
			specTalent.x = 600;
			specTalent.y = 0;
			
			stageRef.addChild(berserkTalent);
			stageRef.addChild(techTalent);
			stageRef.addChild(specTalent);
						
			//Saving
			Engine.so.data.hasSavedData=true;
			Engine.so.data.expPoints=expPoints;
			Engine.so.data.nextLevel=nextLevel;
			Engine.so.data.currentLevel=currentLevel;
			Engine.so.data.talentPoints=talentPoints;
			Engine.so.flush();
			
			SoundMaster.PlayTalentMenuMusic();
		}

		public static function Instance(stageRef:Stage = null):TalentMenu
		{
			if(instance == null)
			{
				allowCallConstructor = true;
				instance = new TalentMenu(stageRef);
				allowCallConstructor = false;
			}
			return instance;
		}

		//Increment expPoints
		public function GainExp(amount:Number): void
		{		
			if(this.currentLevel < 11)
			{
				this.expPoints += amount;
				if(this.nextLevel <= this.expPoints)
					levelUp();
			}
			
		}

		private function levelUp(): void
		{			
			this.currentLevel++;	//lvlUp
			talentPoints += 2;		//+talent
			if(this.currentLevel == 11)		//new xp limit calc or cap at lvl 11
				this.expPoints = this.nextLevel;
			else			
				this.nextLevel = Math.floor(this.nextLevel + 100*Math.pow(1.2, currentLevel));
			dispatchEvent(new Event("levelUp"));	//dispatch event
			
		}

		public function GetLevel():Number
		{
			return this.currentLevel;			
		}

		public function GetTalentPoints():Number
		{
			return this.talentPoints;			
		}
		
		public function DecreaseTalentPoints():void
		{
			this.talentPoints--;
			Engine.so.data.talentPoints=talentPoints;
			Engine.so.flush();
			textTalentPoints.text = String("talent points: " + talentPoints);
		}
		
		public function GetBerserkTalent():BerserkTalent
		{
			return this.berserkTalent;			
		}
		
		public function GetTechTalent():TechTalent
		{
			return this.techTalent;			
		}
		
		public function GetSpecTalent():Talent
		{
			return this.specTalent;			
		}
		
		//Dispose function override
		override protected function dispose(e:Event): void
		{
			/*stageRef.removeChild(berserkTalent);	//ezt nem
			stageRef.removeChild(techTalent);	//tudom hogy
			stageRef.removeChild(specTalent); 	//jó-e*/
			berserkTalent.visible=false;
			techTalent.visible=false;
			specTalent.visible=false;
			super.dispose(e);
		}

	}
	
}
