package soundPackage
{
	import flash.media.SoundMixer;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	
	//Does not support partial muting YET
	public class SoundMaster
	{
		
		private static var muted:Boolean = false;
		private static var effectsVolume:Number = 1;
		private static var musicVolume:Number = 1;
		
		public function SoundMaster(){}
		
		//
		//Music
		//
		//
		
		public static function PlayTalentMenuMusic()
		{
			if(!muted)
			{
				var m:Sound = new TalentMenuMusic();
				var sndtrans:SoundTransform = new SoundTransform(musicVolume, 0);
				m.play(0, 1000, sndtrans);
			}				
		}
		
		public static function PlayMainMenuMusic()
		{
			if(!muted)
			{
				var m:Sound = new MainMenuMusic();
				var sndtrans:SoundTransform = new SoundTransform(musicVolume, 0);
				m.play(0, 1000, sndtrans);
			}				
		}
		
		//
		//Effects
		//
		//
		
		public static function PlayHitSound(num:Number = 0)
		{
			if(!muted)
			{
				var m:Sound;
				var sndtrans:SoundTransform = new SoundTransform(effectsVolume, 0);				
				var chosenNum:Number;
				
				if(num == 0)
					chosenNum = Math.ceil(Math.random()*9);
				else
					chosenNum = num;
				switch(chosenNum)
				{
					case 1:					
						m = new HitSound1();
						sndtrans.volume *= 0.8;
						break;
					case 2:					
						m = new HitSound2();
						sndtrans.volume *= 0.8;
						break;
					case 3:					
						m = new HitSound3();
						sndtrans.volume *= 0.4;
						break;
					case 4:					
						m = new HitSound4();
						sndtrans.volume *= 0.5;
						break;
					case 5:					
						m = new HitSound5();
						sndtrans.volume *= 0.8;
						break;
					case 6:					
						m = new HitSound6();
						sndtrans.volume *= 0.7;
						break;
					case 7:					
						m = new HitSound7();
						sndtrans.volume *= 0.7;
						break;
					case 8:					
						m = new HitSound8();
						sndtrans.volume *= 0.7;
						break;
					case 9:					
						m = new HitSound9();
						sndtrans.volume *= 0.8;
						break;
					default:
						break;
				}
				m.play(0, 0, sndtrans);
			}				
		}
		
		public static function PlayExplosionSound(num:Number = 0)
		{
			if(!muted)
			{
				var m:Sound;
				var sndtrans:SoundTransform = new SoundTransform(effectsVolume*0.1, 0);
				var chosenNum:Number;
				
				if(num == 0)
					chosenNum = Math.ceil(Math.random()*4);
				else
					chosenNum = num;
				switch(chosenNum)
				{
					case 1:					
						m = new ExplosionSound1();
						break;
					case 2:					
						m = new ExplosionSound2();
						break;
					case 3:					
						m = new ExplosionSound3();
						break;
					case 4:					
						m = new ExplosionSound4();
						break;
					default:
						break;
				}
				m.play(0, 0, sndtrans);
			}				
		}
		
		public static function PlayLaserShotSound(num:Number = 0)
		{
			if(!muted)
			{
				var m:Sound;
				var sndtrans:SoundTransform = new SoundTransform(effectsVolume, 0);
				var chosenNum:Number;
				
				if(num == 0)
					chosenNum = Math.ceil(Math.random()*2);
				else
					chosenNum = num;
				switch(chosenNum)
				{
					case 1:					
						m = new LaserShotSound1();
						break;
					case 2:					
						m = new LaserShotSound2();
						break;
					default:
						break;
				}
				m.play(0, 0, sndtrans);
			}				
		}
		
		public static function PlayShieldAbsorbSound(num:Number = 0)
		{
			if(!muted)
			{
				var m:Sound;
				var sndtrans:SoundTransform = new SoundTransform(effectsVolume, 0);
				var chosenNum:Number;
				
				if(num == 0)
					chosenNum = Math.ceil(Math.random()*3);
				else
					chosenNum = num;
				switch(chosenNum)
				{
					case 1:					
						m = new ShieldAbsorbSound1();
						break;
					case 2:					
						m = new ShieldAbsorbSound2();
						break;
					case 3:					
						m = new ShieldAbsorbSound2();
						break;
					default:
						break;
				}
				m.play(0, 0, sndtrans);
			}				
		}
		
		public static function PlayRocketShotSound(num:Number = 0)
		{
			if(!muted)
			{
				var m:Sound;
				var sndtrans:SoundTransform = new SoundTransform(effectsVolume, 0);
				var chosenNum:Number;
				
				if(num == 0)
					chosenNum = Math.ceil(Math.random()*1);
				else
					chosenNum = num;
				switch(chosenNum)
				{
					case 1:					
						m = new RocketShotSound1();
						sndtrans.volume *= 0.5;
						break;
					default:
						break;
				}
				m.play(0, 0, sndtrans);
			}				
		}
		
		public static function PlayLaserBeamSound()
		{
			if(!muted)
			{
				var m:Sound = new LaserBeamSound();
				var sndtrans:SoundTransform = new SoundTransform(effectsVolume, 0);								
				m.play(0, 0, sndtrans);
			}				
		}
		
		//
		//Settings
		//
		//
		
		public static function Mute()
		{
			SoundMixer.stopAll();
			muted = true;
		}
		
		public static function UnMute()
		{
			muted = false;			
		}
		
		public static function IsMuted(): Boolean
		{
			return muted;
		}
		
		public static function SetEffectsVolume(volume:Number)
		{
			effectsVolume = volume;
		}
		
		public static function GetEffectsVolume(volume:Number): Number
		{
			return effectsVolume;
		}
		
		public static function SetMusicVolume(volume:Number)
		{
			musicVolume = volume;
		}
		
		public static function GetMusicVolume(volume:Number): Number
		{
			return musicVolume;
		}
		
		public static function StopAllSounds()
		{
			SoundMixer.stopAll();			
		}
		
	}
	
}