package cn.itamt.net.order.encode 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author tamt
	 */
	public class OrderEncoderMap 
	{
		private static var _map:Dictionary;
		
		public static function register(orderId:uint, encoder:IOrderEncoder):void {
			if (_map == null)_map = new Dictionary();
			_map[orderId] = encoder;
		}
		
		public static function unregister(orderId:uint):void {
			_map[orderId] = null;
			delete _map[orderId];
		}
		
		public static function getEncoder(orderId:uint):IOrderEncoder {
			return _map[orderId];
		}
		
	}

}