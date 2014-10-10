package menuPackage
{
		
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import soundPackage.SoundMaster;
 
	public class MainMenu extends BaseMenu
	{
 
 		private var logoGlowFading:Boolean = true;
 
		public function MainMenu(stageRef:Stage = null)
		{
			super(stageRef, "MainMenu");
			
			//Buttons init
			btnPlay.TextGlow.alpha = 0;
 			btnPlay.ButtonGlow.alpha = 0;
			btnPlay.Text.text = "Play";
			btnPlay.TextGlow.Text.text = "Play";
			btnOptions.TextGlow.alpha = 0;
 			btnOptions.ButtonGlow.alpha = 0;
			btnOptions.Text.text = "Options";
			btnOptions.TextGlow.Text.text = "Options";
			btnCredits.TextGlow.alpha = 0;
 			btnCredits.ButtonGlow.alpha = 0;
			btnCredits.Text.text = "Credits";
			btnCredits.TextGlow.Text.text = "Credits";			
			btnReset.TextGlow.alpha = 0;
 			btnReset.ButtonGlow.alpha = 0;
			btnReset.Text.text = "Reset";
			btnReset.TextGlow.Text.text = "Reset";			
			
			addEventListener(Event.ENTER_FRAME, EnterFrame, false, 0, true);
			SoundMaster.PlayMainMenuMusic();
		} 
 
 		override protected function buttonsActivate(): void
		{			
			//Due to weak reference, removal the listeners will not be necessary
			btnPlay.addEventListener(MouseEvent.CLICK, playGameClick, false, 0, true);
			btnPlay.addEventListener(MouseEvent.MOUSE_OVER, Select, false, 0, true);
			btnPlay.addEventListener(MouseEvent.MOUSE_OUT, DeSelect, false, 0, true);
			btnOptions.addEventListener(MouseEvent.CLICK, optionsMenuClick, false, 0, true);
			btnOptions.addEventListener(MouseEvent.MOUSE_OVER, Select, false, 0, true);
			btnOptions.addEventListener(MouseEvent.MOUSE_OUT, DeSelect, false, 0, true);
			btnCredits.addEventListener(MouseEvent.CLICK, creditsMenuClick,  false, 0, true);
			btnCredits.addEventListener(MouseEvent.MOUSE_OVER, Select, false, 0, true);
			btnCredits.addEventListener(MouseEvent.MOUSE_OUT, DeSelect, false, 0, true);
			btnReset.addEventListener(MouseEvent.CLICK, resetMenuClick,  false, 0, true);
			btnReset.addEventListener(MouseEvent.MOUSE_OVER, Select, false, 0, true);
			btnReset.addEventListener(MouseEvent.MOUSE_OUT, DeSelect, false, 0, true);
		}
 	
 		private function EnterFrame(e:Event): void
		{			
			if(logoGlowFading)
			{
				MainMenuLogo.LogoGlow.alpha -= 0.02;
				if(MainMenuLogo.LogoGlow.alpha <= 0)
					logoGlowFading = false;
			}
			else
			{
				MainMenuLogo.LogoGlow.alpha += 0.02;
				if(MainMenuLogo.LogoGlow.alpha >= 1)
					logoGlowFading = true;				
			}
		}
 
		//Clicking on "play" button
		private function playGameClick(e:MouseEvent) : void
		{
 			SoundMaster.StopAllSounds();
			if(Engine.so.data.heroType == null)
				unload(new CharacterSelectMenu(stageRef));
			else
			{
				GameClass.setHeroType(Engine.so.data.heroType);
				unload(TalentMenu.Instance(stageRef));
			}
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
		
		//Clicking on "options" button
 		private function optionsMenuClick(e:MouseEvent) : void
		{
 			
		}		
 
		//Clicking on "credits" button
		private function creditsMenuClick(e:MouseEvent) : void
		{
			unload(new CreditsMenu(stageRef));
		}
		
		 //Clicking on "reset" button
		private function resetMenuClick(e:MouseEvent) : void
		{
			Engine.so.clear();
		}
		
		 //Dispose function override
 		override protected function dispose(e:Event): void
		{
			super.dispose(e);		
		}
 
	}
	
}
