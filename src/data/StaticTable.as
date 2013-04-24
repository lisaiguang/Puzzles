package data
{
	import com.urbansquall.ginger.Animation;
	import com.urbansquall.ginger.AnimationBmp;
	import com.urbansquall.ginger.AnimationPlayer;
	import com.urbansquall.ginger.tools.AnimationBuilder;
	
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	
	import data.staticObj.AnimationDesc;
	import data.staticObj.BlockDesc;
	import data.staticObj.MapDesc;
	
	import lsg.ani.Light;
	import lsg.sound.BiteMusic;
	import lsg.sound.RotationMusic;
	import lsg.sound.SelectMusic;
	import lsg.sound.YahooMusic;
	import lsg.sound.clickMusic;
	
	import music.SoundPlayer;
	
	public class StaticTable
	{
		public static var STAGE_WIDTH:int  = 640;
		public static var STAGE_HEIGHT:int = 1136;
		
		public static var SCALE_X:Number = 1;
		public static var SCALE_Y:Number = 1;

		[Embed(source = "../../assets/config/animation.xml", mimeType="application/octet-stream")]
		private static var AnimationConfig:Class;
		
		[Embed(source = "../../assets/config/map.xml", mimeType="application/octet-stream")]
		private static var MapConfig:Class;
		
		[Embed(source = "../../assets/config/string.xml", mimeType="application/octet-stream")]
		private static var StringConfig:Class;
		
		public static function Init():void
		{
			xml = new XML(new StringConfig);
			for(i = 0; i < xml.e.length(); i++)
			{
				var ex:XML = xml.e[i];
				STR_DIC[int(ex.@id)] = ex.@str;
			}
			StringConfig = null;
			
			xml = new XML(new AnimationConfig);
			for(i = 0; i < xml.bmp.length(); i++)
			{
				var bmpXml:XML = xml.bmp[i];
				var animations:Array = [];
				BMPNAME2ANIDESCS[String(bmpXml.@name)] = animations;
				for(j=0;j<bmpXml.a.length();j++)
				{
					var aniXml:XML = bmpXml.a[j];
					var aniDesc:AnimationDesc = new AnimationDesc;
					aniDesc.name = aniXml.@name;
					aniDesc.width = Number(aniXml.@width);
					aniDesc.height = Number(aniXml.@height);
					aniDesc.startX = Number(aniXml.@startX);
					aniDesc.startY = Number(aniXml.@startY);
					aniDesc.count = int(aniXml.@count);
					aniDesc.fps = aniXml.hasOwnProperty("@fps")?int(aniXml.@fps):12;
					aniDesc.rotation = aniXml.hasOwnProperty("@rotation")?int(aniXml.@rotation):1;
					aniDesc.loop = aniXml.hasOwnProperty("@loop")?int(aniXml.@loop):true;
					aniDesc.offsetX = aniXml.hasOwnProperty("@offsetX")? Number(aniXml.@offsetX) : -aniDesc.width/2;
					aniDesc.offsetY = aniXml.hasOwnProperty("@offsetY")? Number(aniXml.@offsetY) : -aniDesc.height/2;
					animations.push(aniDesc);
					ANIMATION_DESC.push(aniDesc);
				}
			}
			AnimationConfig = null;
			
			var xml:XML = new XML(new MapConfig);
			for(var i:int = 0; i < xml.map.length(); i++)
			{
				var mapXml:XML = xml.map[i];
				var mapDesc:MapDesc = new MapDesc;
				mapDesc.id = uint(mapXml.@id);
				mapDesc.type = uint(mapXml.@type);
				mapDesc.bg = uint(mapXml.@bg);
				mapDesc.hx = uint(mapXml.@hx);
				mapDesc.hy = uint(mapXml.@hy);
				mapDesc.hh = uint(mapXml.@hh);
				mapDesc.hw = uint(mapXml.@hw);
				for(var j:int = 0; j < mapXml.block.length(); j++)
				{
					var blockXml:XML = mapXml.block[j];
					var blockDesc:BlockDesc = new BlockDesc;
					blockDesc.id = uint(blockXml.@id);
					blockDesc.x = uint(blockXml.@x);
					blockDesc.y = uint(blockXml.@y);
					blockDesc.shuipin = uint(blockXml.@shuipin);
					blockDesc.fanzhuan = uint(blockXml.@fanzhuan);
					blockDesc.finalX = uint(blockXml.@finalX);
					blockDesc.finalY = uint(blockXml.@finalY);
					blockDesc.finalSp = uint(blockXml.@finalSp);
					blockDesc.finalFz = uint(blockXml.@finalFz);
					mapDesc.blocks.push(blockDesc);
				}
				MAP_DESC.push(mapDesc);
			}
			MapConfig = null;
			
			var musiclist:Array = [SelectMusic, RotationMusic, BiteMusic, YahooMusic, clickMusic];
			for(i = 0; i < musiclist.length; i++)
			{
				var sp:SoundPlayer = new SoundPlayer(musiclist[i]);
				_sounds.push(sp);
			}
		}
		
		public static var STR_DIC:Dictionary = new Dictionary;
		
		public static var MAP_DESC:Vector.<MapDesc> = new Vector.<MapDesc>;
		public static function GetMapDesc(id:int):MapDesc
		{
			for(var i:int = 0; i < MAP_DESC.length; i++)
			{
				var bd:MapDesc = MAP_DESC[i];
				if(bd.id == id)return bd;
			}
			return  null;
		}
		
		private static var _sounds:Array = new Array;
		public static function GetSoundPlayer(id:int):SoundPlayer
		{
			return  _sounds[id];
		}
		
		public static function GetBmpData(name:String, cache:Boolean = false):BitmapData
		{
			switch(name)
			{
				case "Light":
					return new Light;
			}
			return null;
		}
		
		public static var ANIMATION_DESC:Vector.<AnimationDesc> = new Vector.<AnimationDesc>;
		public static var BMPNAME2ANIDESCS:Dictionary = new Dictionary;
		public static var BMPNAME2ANIMATIONs:Dictionary = new Dictionary;
		public static function GetAnimationsByBmpName(bn:String):Vector.<Animation>
		{
			var animations:Vector.<Animation> = BMPNAME2ANIMATIONs[bn];
			if(!animations)
			{
				animations = new Vector.<Animation>;
				var bd:BitmapData = GetBmpData(bn);
				var aniDescs:Array = BMPNAME2ANIDESCS[bn];
				for(var i:int = 0; i< aniDescs.length; i++)
				{
					var aniDesc:AnimationDesc = aniDescs[i];
					var animation:Animation = AnimationBuilder.importStrip(aniDesc.fps, bd, aniDesc.width, aniDesc.height, aniDesc.count, aniDesc.startX, aniDesc.startY,
						aniDesc.rotation, aniDesc.offsetX, aniDesc.offsetY);
					animation.isLooping = aniDesc.loop;
					animations.push(animation);
				}
				bd.dispose();
				BMPNAME2ANIMATIONs[bn] = animations;
			}
			return animations;
		}
		
		public static function FreeAnimations():void
		{
			for(var key:String in BMPNAME2ANIMATIONs)
			{
				delete BMPNAME2ANIMATIONs[key];
			}
		}
		
		public static function GetAniPlayerByName(name:String):AnimationPlayer
		{
			var ab:AnimationPlayer = new AnimationPlayer;
			var animations:Vector.<Animation> = GetAnimationsByBmpName(name);
			var aniDescs:Array = BMPNAME2ANIDESCS[name];
			for(var i:int = 0; i<animations.length; i++)
			{
				ab.addAnimation(aniDescs[i].name, animations[i]);
			}
			return ab;
		}
		
		public static function GetAniBmpByName(name:String):AnimationBmp
		{
			var ab:AnimationBmp = new AnimationBmp;
			var animations:Vector.<Animation> = GetAnimationsByBmpName(name);
			var aniDescs:Array = BMPNAME2ANIDESCS[name];
			for(var i:int = 0; i<animations.length; i++)
			{
				ab.addAnimation(aniDescs[i].name, animations[i]);
			}
			return ab;
		}
	}
}