package msc.events {

	/**
	 * @author itamt[at]qq.com
	 */
	public class mTextEvent extends mEvent {
		//输入完成时触发
		public static const ENTER : String = 'm_text_enter';

		public var text : String;

		public function mTextEvent(type : String, text : String = null, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
			
			this.text = text;
		}
	}
}