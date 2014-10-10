package menuPackage
{
	
	import flash.display.Stage;
	import flash.display.MovieClip;
	import flash.filters.ColorMatrixFilter;
	
	public class Talent extends MovieClip
	{

		protected var talents:Array;
		protected var talentsDescription:Array;
		public var stageRef:Stage;

		public function Talent(talentsDescription:Array)
		{
			talents = new Array(0, 0, 0, 0);
			this.talentsDescription = talentsDescription;
		}
		
		public function GetTalent(index:Number):Number
		{
			return talents[index];
		}

		protected function incrementTalent(index:Number):void
		{
			if(talents[index] < 5 && index < 3)
			{
				if(talents[index-1] == 5 || index == 0)
				{
					talents[index]++;
					TalentMenu.Instance().DecreaseTalentPoints();
				}
			}
			else if(talents[index] < 1 && index == 3 && talents[index-1] == 5)
			{
				talents[index]++;
				TalentMenu.Instance().DecreaseTalentPoints();
			}
		}
		
		protected function grayscale(e:MovieClip){
			var b:Number = 1 / 3;
			var c:Number = 1 - (b * 2);
			var mtx:Array = [c, b, b, 0, 0,
							b, c, b, 0, 0,
							b, b, c, 0, 0,
							0, 0, 0, 1, 0];
			var mtxFilter:ColorMatrixFilter = new ColorMatrixFilter(mtx);
			e.filters = [mtxFilter];
		}
		
		protected function unGrayscale(e:MovieClip){
			e.filters = [];
		}
	}
	
}
