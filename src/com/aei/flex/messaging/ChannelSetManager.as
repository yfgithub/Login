package com.aei.flex.messaging
{
	
	import mx.core.FlexGlobals;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.channels.SecureAMFChannel;
	import mx.messaging.channels.StreamingAMFChannel;
	
	/**
	 * 
	 * Title : ChannelSetManager 管理各种消息通道
	 * <p/>
	 * Description :
	 * <p/>
	 * CopyRight : CopyRight (c) 2011
	 * <p/>
	 * Company : 亚信联创科技(中国)有限公司
	 * <p/>
	 * Flex SDK Version Used : SDK 4.0
	 * <p/>
	 * Modification History :
	 * <p/>
	 * 
	 * <pre>
	 * NO.    Date    Modified By    Why &amp; What is modified
	 * </pre>
	 * 
	 * <pre>
	 *   
	 * </pre>
	 * <p/>
	 * 
	 * @author hanjn
	 * @version 1.0.0
	 * @date 2011-4-17
	 */
	public class ChannelSetManager
	{
		public function ChannelSetManager()
		{
		}
		
		public static var SWF_PATH:String="login/Login.swf";
		
		
		public static var MY_AMF:String="my-amf";//amf的channelId
		
		public static var MY_SECURE_AMF:String="my-secure-amf";//amf的channelId
		
		public static var MESSAGEBROKER_AMF:String="messagebroker/amf";//amf的uri
		
		public static var MESSAGEBROKER_SECURE_AMF:String="messagebroker/amfsecure";//amf的uri
		
		
		public static var MY_STREAM_AMF:String="my-streaming-amf";//streaming的channelId
		
		public static var MESSAGEBROKER_STREAMING_AMF:String="messagebroker/streamingamf";//streamingamf的uri
		
		
		public static var MY_POLLING_AMF:String="my-polling-amf";//polling的channelId
		
		public static var MESSAGEBROKER_AMF_POLLING:String="messagebroker/amfpolling";//polling的uri
		
		public static var AMF:String="amf";//amf类型
		public static var STREAM:String="stream";//stream类型
		
		/**
		 * 远程对象的消息通道设置
		 * @return ChannelSet 
		 */
		public  function getRemoteObjectChannelSet():ChannelSet {
			var channelSet:ChannelSet=new ChannelSet();
			var uri:String=getWebRoot();
			if(uri.indexOf("https")!=-1){
				channelSet=getAmfChannelSet(channelSet,AMF,MY_SECURE_AMF,MESSAGEBROKER_SECURE_AMF,true);
			}else{
				channelSet=getAmfChannelSet(channelSet,AMF,MY_AMF,MESSAGEBROKER_AMF);
			}
			/*Debug.delimiter();
			Debug.trace("channelSet: ",Debug.LEVEL_WARN);
			Debug.traceObj(channelSet.channels,64,Debug.LEVEL_WARN);
			Debug.delimiter();*/
			return channelSet;
		}
		/**
		 * 消息服务(JMS)通道设置
		 * @return ChannelSet
		 * 
		 */
		public  function getMessageChannelSet():ChannelSet{
			var channelSet:ChannelSet=new ChannelSet();
			channelSet=getAmfChannelSet(channelSet,AMF,MY_POLLING_AMF,MESSAGEBROKER_AMF_POLLING,true);
			channelSet=getAmfChannelSet(channelSet,STREAM,MY_STREAM_AMF,MESSAGEBROKER_STREAMING_AMF,true);
			return channelSet;
		}
		/**
		 * 设置AMFChannel
		 * @param ChannelSet channelSet 不能为空
		 * @param String  channelType channel的类型 AMFChannel或者StreamingAMFChannel 不能为空
		 * @param String  id 通道id 不能为空
		 * @param String  servletUrl 通道处理类的url 不能为空
		 * @param Boolean pollingEnabled是否轮询 可以为空 默认值为false
		 * @param Boolean pollingInterval轮询间隔 可以为空 默认值是3000
		 * @param ChannelSet 
		 */
		private function getAmfChannelSet(channelSet:ChannelSet,channelType:String,id:String,servletUrl:String,isSecure:Boolean=false,pollingEnabled:Boolean=false,pollingInterval:int=3000):ChannelSet{
			var uri:String=getWebRoot()+servletUrl;
			var amfChannel:AMFChannel=null;
			if(AMF==channelType){
				if(isSecure){
					amfChannel=new SecureAMFChannel(id,uri);
				}else{
					amfChannel= new AMFChannel(id,uri);
				}
			}else if(STREAM==channelType){
				amfChannel= new StreamingAMFChannel(id,uri);
			}
			amfChannel.pollingEnabled =pollingEnabled;
			amfChannel.pollingInterval=pollingInterval;
			channelSet.addChannel(amfChannel);
			return channelSet;
		}
		
		/**
		 * 得到应用的跟目录 
		 * @return 类似：http://{server.name}:{server.port}/{context.root}/
		 * 
		 */
		public static  function  getWebRoot():String{
			var loadInfoUrl:String=FlexGlobals.topLevelApplication.loaderInfo.url;
			var index:int=loadInfoUrl.indexOf(SWF_PATH);
			var webRoot:String=loadInfoUrl.substring(0,index);
			return webRoot;
		}
	}
}