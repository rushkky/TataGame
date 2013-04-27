package view.panel
{
	import datas.PanelData.PanelData;
	
	import enum.AlignType.AlignType;
	import enum.AlignType.DepthType;
	import enum.EventType.EventType;
	import enum.EventType.MyEvent;
	import enum.ResType.ResType;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	
	import gtool.GLoader;
	import gtool.GMsg;
	import gtool.GTool;
	
	import modules.UIModule;

	public class PanelManager
	{
		private static var _instance:PanelManager;
		private var pdMap:Dictionary;
		private var gl:GLoader;
		private var gm:GMsg;
		private var um:UIModule;
		
		public function PanelManager()
		{
			_instance = this;
			gl = GTool.GetInstance().gl;
			gm = GTool.GetInstance().gm;
			um = UIModule.GetInstance();
			pdMap = new Dictionary();
		}
		public function loadLoadPanel(callback_:Function):void
		{
			var pd:PanelData = new PanelData();
			pd.name = "LoadPanel";
			pd.info = "加载面板";
			pd.pos = AlignType.MID_MID;
			pd.depth = DepthType.MID;
			pd.panel = null;
			this.pdMap[pd.name] = pd;
			
			this.load("LoadPanel",callback_);
		}
		
		//只能执行一次
		public function init(data_:XML):void
		{
			var xml:XML = data_;
			var xmlList:XMLList = xml.panel;
			var len:int = xmlList.length();
			for(var i:int=0;i<len;++i)
			{
				var pd:PanelData = new PanelData();
				pd.setData(xmlList[i]);
				pdMap[pd.name] = pd;
			}
		}
		/**
		 *加载面板 
		 * @param name_
		 * @param callback_
		 * @param data_
		 * 
		 */		
		public function load(name_:String,callback_:Function,data_:Object=null):void
		{
			var url:String = "/panel/"+name_+"/"+name_+".swf";
			this.gl.load(url,ResType.SWF,name_);
			this.gm.addMsgListener(this,EventType.RES_LOAD,onResLoad);
			function onResLoad(e:MyEvent):void
			{
				var key:String = e.key;
				var cls:Class = gl.getClass(key,"view.panel."+key+"."+key);
				if(cls != null)
				{
					if(pdMap[key] != null)
					{
						var pd:PanelData = pdMap[key];
						pd.panel = new cls();
						pd.panel.setData(data_);
						um.addToStage(pd);
						if(callback_!=null) callback_();
					}
					else
					{
						trace("PanelConfig.xml中没有找到"+key+"面板的配置！");
					}
					
				}
				this.gl.remove(name_);
				this.gm.removeMsgListener(this,EventType.RES_LOAD,onResLoad);
			}
		}
		public function show(pd_:PanelData):void
		{

		}
		public function hide():void
		{
			
		}
		/**
		 *关闭面板 
		 * @param arrName_
		 * 
		 */		
		public function close(arrName_:Array):void
		{
			var len:int = arrName_.length;
			for(var i:int = 0;i<len;++i)
			{
				var pd:PanelData = this.pdMap[arrName_[i]];
				if(pd != null)
				{
					var panel:PanelBase = pd.panel;
					if(panel != null)
					{
						var parent:Sprite = panel.parent as Sprite;
						if(parent != null)
						{
							parent.removeChild(panel);
						}
						else
						{
							trace("面板:"+pd.name+"找不到父级!");
						}
						panel.close();
						panel = null;
					}
				}
			}
		}
		/**
		 *移除所有面板 
		 * @param arrName_
		 * 不需要移除的面板
		 */		
		public function closeAll(arrName_:Array=null):void
		{
			for(var key:String in this.pdMap)
			{
				var pd:PanelData = this.pdMap[key];
				if(pd == null) continue;
				var panel:PanelBase = pd.panel;
				if(panel != null)
				{
					var bFind:Boolean = false;
					if(arrName_ != null)
					{
						var len:int = arrName_.length;
						for(var i:int = 0;i<len;++i)
						{
							if(pd.name == arrName_[i])
							{
								bFind = true;
								break;
							}
						}
					}
					
					if(!bFind)
					{
						var parent:Sprite = panel.parent as Sprite;
						if(parent != null)
						{
							parent.removeChild(panel);
						}
						else
						{
							trace("面板:"+pd.name+"找不到父级!");
						}
						panel.close();
						panel = null;
					}
		
				}
			}
		}
		public static function GetInstance():PanelManager
		{
			if(!_instance) new PanelManager();
			return _instance;
		}
	}
}