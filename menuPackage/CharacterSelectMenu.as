package  menuPackage
{
	
	import menuPackage.*;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class CharacterSelectMenu extends BaseMenu
	{
		private var selectedHero:Number = 0;
		private var targetCoord:Vector2D = new Vector2D();;

		public function CharacterSelectMenu(stageRef:Stage = null) 
		{
			super(stageRef, "CharacterSelect");
			
			//Buttons init
			btnStart.TextGlow.alpha = 0;
 			btnStart.ButtonGlow.alpha = 0;
			btnStart.Text.text = "Start";
			btnStart.TextGlow.Text.text = "Start";
			
			background_mc.lamp01_mc.visible = false;
			background_mc.lamp0102_mc.visible = false;
			
			addEventListener(Event.ENTER_FRAME, onEnterFrame, false, 0, true);
		}

		override protected function buttonsActivate(): void
		{			
			//Due to weak reference, removal the listeners will not be necessary
			btnStart.addEventListener(MouseEvent.CLICK, startClick, false, 0, true);
			btnStart.addEventListener(MouseEvent.MOUSE_OVER, Select, false, 0, true);
			btnStart.addEventListener(MouseEvent.MOUSE_OUT, DeSelect, false, 0, true);
			btnRight.addEventListener(MouseEvent.CLICK, rightClick, false, 0, true);
			btnLeft.addEventListener(MouseEvent.CLICK, leftClick, false, 0, true);
		}		

		private function onEnterFrame(e:Event) : void
		{
			background_mc.x = 0.9*background_mc.x + 0.1*targetCoord.x;
		}

		private function startClick(e:MouseEvent) : void
		{
			GameClass.setHeroType(selectedHero);
			unload(GameClass.Instance(stageRef));
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
		
		private function rightClick(e:MouseEvent) : void
		{
 			switch(selectedHero)
			{
				case 0: 
					selectedHero = 2;
					targetCoord.x = -800;
					background_mc.lamp01_mc.visible = true;
					background_mc.lamp02_mc.visible = false;
					background_mc.lamp0203_mc.visible = false;
					break;
				case 2:
					selectedHero = 1;
					targetCoord.x = -1600;
					background_mc.lamp02_mc.visible = true;
					background_mc.lamp03_mc.visible = false;
					background_mc.lamp0102_mc.visible = true;
					break;
				default:
					break;					
			}
		}
		
		private function leftClick(e:MouseEvent) : void
		{
 			switch(selectedHero)
			{
				case 2: 
					selectedHero = 0;
					targetCoord.x = 0;
					background_mc.lamp02_mc.visible = true;
					background_mc.lamp01_mc.visible = false;
					background_mc.lamp0203_mc.visible = true;
					break;
				case 1:
					selectedHero = 2;
					targetCoord.x = -800;
					background_mc.lamp03_mc.visible = true;
					background_mc.lamp02_mc.visible = false;
					background_mc.lamp0102_mc.visible = false;
					break;
				default:
					break;					
			}
		}
		
	}
	
}
