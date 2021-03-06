package cn.itamt.net.order.model.server 
{
	import cn.itamt.net.order.Order;
	import cn.itamt.net.order.OrderByteArray;
	/**
	 * ...
	 * @author tamt
	 */
	public class ServerChatResultData implements IServerOrderData 
	{
		private var _name:String;
		private var _msgId:uint;
		
		public function ServerChatResultData() 
		{
			
		}
		
		/* INTERFACE com.zhongCheng.order.model.server.IServerOrderData */
		
		public function decode(order:Order):void 
		{
			var data:OrderByteArray = order.body;
			data.position = 0;
			_name = data.readString(data.readByte());
			_msgId = data.read32uint();
		}
		
		/**
		 * 发送人的用户名
		 */
		public function get name():String 
		{
			return _name;
		}
		
		/**
		 * 所发送信息的id
		 */
		public function get msgId():uint 
		{
			return _msgId;
		}
		
	}

}