package menuPackage
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class LaserTalent extends Talent
	{

		public function LaserTalent(stageRef:Stage = null) 
		{
			var td:Array = ["0", "1", "2", "3"];
			super(td);
			
			//Button events
			button00.addEventListener(MouseEvent.MOUSE_DOWN, buttonClick);
			button01.addEventListener(MouseEvent.MOUSE_DOWN, buttonClick);
			button02.addEventListener(MouseEvent.MOUSE_DOWN, buttonClick);
			button03.addEventListener(MouseEvent.MOUSE_DOWN, buttonClick);
			button00.addEventListener(MouseEvent.MOUSE_OVER, buttonOver);
			button01.addEventListener(MouseEvent.MOUSE_OVER, buttonOver);
			button02.addEventListener(MouseEvent.MOUSE_OVER, buttonOver);
			button03.addEventListener(MouseEvent.MOUSE_OVER, buttonOver);
			button00.addEventListener(MouseEvent.MOUSE_OUT, buttonOut);
			button01.addEventListener(MouseEvent.MOUSE_OUT, buttonOut);
			button02.addEventListener(MouseEvent.MOUSE_OUT, buttonOut);
			button03.addEventListener(MouseEvent.MOUSE_OUT, buttonOut);
			
			//Initialize button appeareance
			this.grayscale(button01);
			this.grayscale(button02);
			this.grayscale(button03);
			button00.Glow.alpha = 0;
			button01.Glow.alpha = 0;
			button02.Glow.alpha = 0;
			button03.Glow.alpha = 0;
			
			if (Engine.so.data.laserArray!=undefined)
			{
				talents=Vector2D.deepcopy(Engine.so.data.laserArray);
				refreshButtonsAfterLoad();
			}
		}

		private function buttonClick(e:Event):void
		{
			if(TalentMenu.Instance(stageRef).GetTalentPoints() > 0)
			{
				switch(e.currentTarget)
				{
					case button00:
					{
						this.incrementTalent(0);
						number00.text = String(talents[0]);
						if(talents[0] == 5)
						{
							this.unGrayscale(button01);
							button00.Glow.alpha = 1;
						}
						break;
					}				
					case button01:
					{
						this.incrementTalent(1);
						number01.text = String(talents[1]);
						if(talents[1] == 5)
						{
							this.unGrayscale(button02);
							button01.Glow.alpha = 1;
						}
						break;
					}
					case button02:
					{
						this.incrementTalent(2);
						number02.text = String(talents[2]);
						if(talents[2] == 5)
						{
							this.unGrayscale(button03);
							button02.Glow.alpha = 1;
						}
						break;
					}
					case button03:
					{
						this.incrementTalent(3);
						number03.text = String(talents[3]);
						if(talents[3] == 1)
						{
							this.unGrayscale(button03);
							button03.Glow.alpha = 1;
						}
						break;
					}
				}
			}
			Engine.so.data.hasSavedData=true;
			Engine.so.data.laserArray=Vector2D.deepcopy(talents);
			Engine.so.flush();
		}
		
		private function buttonOver(e:Event):void
		{
			switch(e.currentTarget)
			{
				case button00:
				{
					TalentMenu.Instance().textDescription.text = this.talentsDescription[0];
					break;
				}
				case button01:
				{
					TalentMenu.Instance().textDescription.text = this.talentsDescription[1];
					break;
				}
				case button02:
				{
					TalentMenu.Instance().textDescription.text = this.talentsDescription[2];
					break;
				}
				case button03:
				{
					TalentMenu.Instance().textDescription.text = this.talentsDescription[3];
					break;
				}
			}
		}
		
		private function buttonOut(e:Event):void
		{
			TalentMenu.Instance().textDescription.text = "";
		}

		private function refreshButtonsAfterLoad()
		{
			if (talents[0]>0)
			{
				this.unGrayscale(button01);
				number00.text=String(talents[0]);
				if (talents[0]==5) button00.Glow.alpha=1;
			}
			if (talents[1]>0)
			{
				this.unGrayscale(button02);
				number01.text=String(talents[1]);
				if (talents[1]==5) button01.Glow.alpha=1;
			}
			if (talents[2]>0)
			{
				this.unGrayscale(button03);
				number02.text=String(talents[2]);
				if (talents[2]==5) button02.Glow.alpha=1;
			}
			if (talents[3]>0)
			{
				number03.text=String(talents[3]);
				button03.Glow.alpha=1;
			}
		}
		
	}
	
}
