package background
{
	import background.*;
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class BackgroundClass extends MovieClip	//elég lenne az EventDispatchert extendelni, de ártani ez se fog
	{
		
		var scenery:Array=new Array();	//az index meghatározza a z-ordert
		var stageRef:Stage;
		
		public function BackgroundClass(s:Stage)
		{
			stageRef=s;
			addEventListener("enterFrame", enterFrame);
		}
		
		public function newBackground(array:Array)	//átadunk egy inicializált Background01_01-ekből álló tömböt 
		{
			for(var i in array)
			{
				scenery.push(array[i]);
				stageRef.addChild(scenery[i]);
				if (i>0) scenery[i].y=stageRef.stageHeight;	//így az első elem (ami az ég) a bal felső sarokba kerül
				//a többi meg a bal alsóba
			}
		}
		
		protected function enterFrame(e:Event)
		{
			for(var i in scenery)
			{
				scenery[i].enterFrame(e);
			}
		}
		
		public function setSpeeds(array:Array)
		{
			for(var i in scenery)
			{
				scenery[i].setSpeed(new Number(array[i]));
			}
		}
		
		public function killBackground()
		{
			for(var i in scenery)
			{
				scenery[i].kill();
			}
			scenery=new Array;
		}
	}
}