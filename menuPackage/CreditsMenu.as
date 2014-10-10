package menuPackage
{
	
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class CreditsMenu extends BaseMenu
	{

		public function CreditsMenu(stageRef:Stage = null)
		{
			super(stageRef, "CreditsMenu");
						
			//Buttons init
			btnBack.TextGlow.alpha = 0;
 			btnBack.ButtonGlow.alpha = 0;
			btnBack.Text.text = "Back";
			btnBack.TextGlow.Text.text = "Back";
		}

		override protected function buttonsActivate(): void
		{	
			//Due to weak reference, removal the listeners will not be necessary
			btnBack.addEventListener(MouseEvent.MOUSE_DOWN, backClick, false, 0, true);
			btnBack.addEventListener(MouseEvent.MOUSE_OVER, Select, false, 0, true);
			btnBack.addEventListener(MouseEvent.MOUSE_OUT, DeSelect, false, 0, true);		
		}
		
		//Clicking on "back" button
		private function backClick(e:Event): void
		{
			unload(new MainMenu(stageRef));			
		}
		
		//Hovering over a button
		private function Select(e:Event): void
		{
			e.currentTarget.TextGlow.alpha = 1;
 			e.currentTarget.ButtonGlow.alpha = 1;
		}
		
		//Unhovering from a button
		private function DeSelect(e:Event): void
		{
			e.currentTarget.TextGlow.alpha = 0;
 			e.currentTarget.ButtonGlow.alpha = 0;
		}

		//Dispose function override
		override protected function dispose(e:Event): void
		{
			super.dispose(e);		
		}
	
	}
	
}
