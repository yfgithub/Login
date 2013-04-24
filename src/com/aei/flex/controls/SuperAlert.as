package com.aei.flex.controls
{
	import mx.controls.Alert;

	/**
	 * 
	 * Title : SuperAlert
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
	 * @date 2011-5-11
	 */
	public class SuperAlert extends Alert
	{
		public function SuperAlert()
		{
		}
		
		[Embed(source="images/msoft/alert_error.gif")]
		private static var iconError:Class;
		
		[Embed(source="images/msoft/alert_info.gif")]
		private static var iconInfo:Class;
		
		[Embed(source="images/msoft/alert_confirm.gif")]
		private static var iconConfirm:Class;
		
		public static function info(message:String, closehandler:Function=null):void{
			show(message, "提醒", Alert.OK, null, closehandler, iconInfo);
		}
		
		public static function error(message:String, closehandler:Function=null):void{
			show(message, "错误", Alert.OK, null, closehandler, iconError);
		}
		
		public static function confirm(message:String, closehandler:Function=null):void{
			show(message, "确认信息", Alert.YES | Alert.NO, null, closehandler, iconConfirm);
		}
	}
}