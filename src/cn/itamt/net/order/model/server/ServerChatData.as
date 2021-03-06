package cn.itamt.net.order.model.server 
{
	import cn.itamt.net.order.Order;
	import cn.itamt.net.order.OrderByteArray;
	import cn.itamt.utils.Debug;
	/**
	 * ...
	 * @author tamt
	 */
	public class ServerChatData implements IServerOrderData 
	{
		
		private var _name:String;
		private var _time:String;
		private var _msg:String;
		private var _receiveName:String;
		
		public function ServerChatData() 
		{
			
		}
		
		public function decode(order:Order):void {
			var data:OrderByteArray = order.body;
			data.position = 0;
			var receiveNameL:uint = data.readByte();
			var receiveName:String = data.readString(receiveNameL);
			var nameL:uint = data.readByte();
			var name:String = data.readString(nameL);
			var msgId:uint = data.read32uint();
			var time:String = data.readString(14);
			var msgL:uint = data.read16int();
			var msg:String = data.readString();
			
			Debug.trace("rNameL: " + receiveNameL + "rName: " + receiveName + "nameL: " + nameL + "\nname: " + name + "\nmsgId: " + msgId + "\ntime: " + time + "\nmsgL: " + msgL + "\nmsg: " + msg);
			
			_name = name;
			_time = time;
			_msg = msg;
			_receiveName = receiveName;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get time():String 
		{
			return _time;
		}
		
		public function get msg():String 
		{
			return _msg;
		}
		
	}

}