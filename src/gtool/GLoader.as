package gtool
{
	import datas.LoadData.LoadData;
	
	import enum.EventType.EventType;
	import enum.EventType.MyEvent;
	import enum.ResType.ResType;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	

	public class GLoader extends EventDispatcher
	{
		private static var _instance:GLoader;
		private static var PrePath:String="";
		private static var Ver:String="";
		
		
		private var loadList:Array;
		private var dataMap:Dictionary;
		
		private var loader:Loader;
		private var urlloader:URLLoader;
		private var req:URLRequest;
		
		private var isLoading:Boolean = false;
		
		private var gm:GMsg;

		
		public function GLoader()
		{
			_instance = this;
			this.init();
			this.initListener();
		}
		private function init():void
		{
			this.loadList = new Array();
			this.dataMap = new Dictionary();
			
			loader = new Loader();
			urlloader = new URLLoader();
			req = new URLRequest();
			
			gm = GTool.GetInstance().gm;
		}
		private function initListener():void
		{
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,onError);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,onProgress);
			
			urlloader.addEventListener(Event.COMPLETE,onComplete);
			urlloader.addEventListener(IOErrorEvent.IO_ERROR,onError);
			urlloader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onError);
			urlloader.addEventListener(ProgressEvent.PROGRESS,onProgress);
		}
		public static function setPathVer(prePath_:String,ver_:String):void
		{
			var endPos:int = prePath_.length - 1;
			if(prePath_.charAt(endPos) == "/")
			{
				prePath_ = prePath_.substring(0,endPos);
			}
			PrePath = prePath_;
			Ver = ver_;
		}
		public function getRes(key_:String):*
		{
			return this.dataMap[key_];
		}
		public function getClass(key_:String,cls_:String):Class
		{
			var obj:DisplayObject = this.dataMap[key_] as DisplayObject;
			if(obj != null)
			{
				if(obj.loaderInfo.applicationDomain.hasDefinition(cls_))
				{
					var cls:Class = obj.loaderInfo.applicationDomain.getDefinition(cls_) as Class;
					return cls;
				}
				else
				{
					return null;
				}
			}
			return null;
		}
		public function load(url_:String,type_:int,key_:String):void
		{
			if(this.dataMap[key_]==null)
			{
				var ld:LoadData = new LoadData();
				ld.url = url_;
				ld.type = type_;
				ld.key = key_;
				this.loadList.push(ld);
			}
			//没有加载过
			if(!isLoading)
			{
				startLoad();
			}
		}
		public function remove(key_:String):void
		{
			this.dataMap[key_] = null;
			delete this.dataMap[key_];
		}
		private function onComplete(e:Event):void
		{	
			this.isLoading = false;
			var ld:LoadData = this.loadList.shift();
			switch(ld.type)
			{
				case ResType.SWF:
				case ResType.IMAGE:
					this.dataMap[ld.key] = this.loader.content;
					break;
				case ResType.TEXT:
					this.dataMap[ld.key] = XML(this.urlloader.data);
					break;
				case ResType.BYE:
					break;
			}
			
			var event:MyEvent = new MyEvent(EventType.RES_LOAD);
			event.key = ld.key;
			event.value = this.dataMap[ld.key];
			this.dispatchEvent(event);
			
			gm.dispatchMsgEvent(EventType.RES_LOAD,event);
			trace(ld.key+"加载成功");
			
			this.checkLoad();
		}
		private function onError(e:Event):void
		{
			this.isLoading = false;
			var ld:LoadData = this.loadList.shift();
			
			trace(ld.key+"加载失败:"+ld.url);
			this.checkLoad();
		}
		private function onProgress(e:ProgressEvent):void
		{
			var ld:LoadData = this.loadList[0];
			var event:MyEvent = new MyEvent(EventType.RES_PROGRESS);
			event.key = ld.key;
			event.value = [ld,e];
			this.dispatchEvent(event);
		}
		private function startLoad():void
		{
			var ld:LoadData = this.loadList[0] as LoadData;
			//处理URL
			var url1:String = ld.url;
			var url2:String = ld.url;
			var reqIndex:int = url2.lastIndexOf("?");
			if(reqIndex < 0)
			{
				url2 = url1 + Ver;
			}
			else
			{
				if(url2.lastIndexOf(Ver) != reqIndex)
				{
					url2 = url2 + "&" + Ver.substring(1);
				}
			}
			
			if(url2.charAt(0) == "/")
			{
				if(PrePath == "")
				{
					url2 = url2.substring(1);
				}
				else
				{
					url2 = PrePath + url2;
				}
						
			}
			
			switch(ld.type)
			{
				case ResType.SWF:
				case ResType.IMAGE:
					//全局域加？
					this.req.url = url2;
					this.loader.load(this.req);
					break;
				case ResType.TEXT:
				case ResType.BYE:
					this.urlloader.dataFormat = URLLoaderDataFormat.BINARY;
					this.req.url = url2;
					this.urlloader.load(this.req);
					break;
			}
			this.isLoading = true;
	
		}
		private function checkLoad():void
		{
			if(this.loadList.length>0)
			{
				this.startLoad();	
			}
			else
			{
				this.dispatchEvent(new MyEvent(EventType.RES_ALLLOAD));
				this.gm.dispatchMsgEvent(EventType.RES_ALLLOAD);
				trace("全部加载完");
			}
		}

		public static function GetInstance():GLoader
		{
			if(!_instance) new GLoader();
			return _instance;
		}
	}
}
