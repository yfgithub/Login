package com.aei.flex.rpc.remoting
{
	import com.aei.flex.messaging.ChannelSetManager;
	
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	/**
	 * 与后台进行交互的核心类
	 * @author 韩敬诺
	 * @version 1.0
	 * @date 2011-3-1
	 * */
	public class RemoteObjectService
	{
		private static var remoteObjectService:RemoteObjectService=null;//RemoteObjectService对象 单例模式
		
		public function RemoteObjectService()
		{
			
		}
		/**
		 * 得到RpcService实例
		 * @return RpcService一个实例
		 * 
		 */
		public static function  getInstance():RemoteObjectService {
			if(remoteObjectService==null){
				remoteObjectService=new RemoteObjectService();
			}
			return remoteObjectService;
		}
		/**
		 * 
		 * 创建一个AbstractOperation后调用send方法与后台交互，send可以传不定个数的参数
		 * todo 校验身份权限  session 异常处理  
		 * @param  destination 消息目标destination   不能为空
		 * @param  methodName  方法名  不能为空
		 * @param  resultHandler 成功处理函数 可为空
		 * @param  faultHandler  失败处理函数 可为空
		 * @param  showBusyCursor 光标是否显示忙碌状态
		 * @return AbstractOperation 
		 */
		public function createOperation(destination:String,methodName:String,resultHandler:Function=null,faultHandler:Function=null,showBusyCursor:Boolean=true):AbstractOperation{
			//Debug.trace("methodName="+methodName+" "+showBusyCursor);
			var remoteObject:RemoteObject=createRemoteObject(destination,showBusyCursor);
			var operation:AbstractOperation=remoteObject.getOperation(methodName);
			if(resultHandler!=null){
				operation.addEventListener(ResultEvent.RESULT,resultHandler);
			}
			if (faultHandler!=null){
				operation.addEventListener(FaultEvent.FAULT,faultHandler);
			}
			return operation;
		}
		/**
		 * 
		 * 调用后台XxxService类的一个方法
		 * @param  destination 消息目标destination   不能为空
		 * @param  methodName  方法名  不能为空
		 * @param  param 参数 注意参数类型必须是Object，对应java端的类型是ASObject
		 * @param  resultHandler 成功处理函数 可为空
		 * @param  faultHandler  失败处理函数 可为空
		 * @param  showBusyCursor 光标是否显示忙碌状态
		 * @return void 
		 */
		public function send(destination:String,methodName:String,param:Object,resultHandler:Function=null,faultHandler:Function=null,showBusyCursor:Boolean=true):void{
			var operation:AbstractOperation=createOperation(destination,methodName,resultHandler,faultHandler,showBusyCursor);
			operation.send(param);
		}
		/**
		 * 创建一个 RemoteObject
		 * @param destination 消息目标
		 * @param showBusyCursor 光标是否是忙碌状态
		 * @return 一个新的RemoteObject
		 * 
		 */
		private function createRemoteObject(destination:String,showBusyCursor:Boolean):RemoteObject{
			var remoteObject:RemoteObject=new RemoteObject();
			var channelManager:ChannelSetManager=new ChannelSetManager();
			remoteObject.channelSet=channelManager.getRemoteObjectChannelSet();
			remoteObject.destination=destination;
			remoteObject.showBusyCursor=showBusyCursor;
			return remoteObject;
		}
	}
}