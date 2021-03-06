package cn.itamt.utils.inspector.plugins.controlbar {
	import cn.itamt.utils.inspector.lang.InspectorLanguageManager;
	import cn.itamt.utils.inspector.ui.InspectorButton;
	import cn.itamt.utils.inspector.ui.InspectorSymbolIcon;

	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;

	/**
	 * @author itamt@qq.com
	 */
	public class InspectorOnOffButton extends InspectorButton {
		public function InspectorOnOffButton() {
			super();

			_tip = InspectorLanguageManager.getStr('InspectorOnOff');
		}

		override protected function buildUpState() : DisplayObject {
			var sp : Shape = new Shape();
			var g : Graphics = sp.graphics;

			g.beginFill(0xffffff, 0);
			g.drawRoundRect(0, 0, 23, 23, 10, 10);
			g.endFill();

			var bmd : BitmapData = InspectorSymbolIcon.getIcon(InspectorSymbolIcon.LOGO);
			g.beginBitmapFill(bmd, new Matrix(1, 0, 0, 1, (23 - bmd.width) / 2, (23 - bmd.height) / 2), false);
			g.drawRect((23 - bmd.width) / 2, (23 - bmd.height) / 2, bmd.width, bmd.height);
			g.endFill();

			return sp;
		}

		override protected function buildOverState() : DisplayObject {
			var sp : Shape = new Shape();
			var g : Graphics = sp.graphics;

			g.beginFill(0xcccccc, 1);
			g.drawRoundRect(0, 0, 23, 23, 10, 10);
			g.endFill();

			var bmd : BitmapData = InspectorSymbolIcon.getIcon(InspectorSymbolIcon.LOGO);
			g.beginBitmapFill(bmd, new Matrix(1, 0, 0, 1, (23 - bmd.width) / 2, (23 - bmd.height) / 2), false);
			g.drawRect((23 - bmd.width) / 2, (23 - bmd.height) / 2, bmd.width, bmd.height);
			g.endFill();

			return sp;
		}

		override protected function buildDownState() : DisplayObject {
			var sp : Shape = new Shape();
			with(sp) {
				graphics.beginFill(0xcccccc, 1);
				graphics.drawRoundRect(0, 0, 23, 23, 10, 10);
				graphics.endFill();
			}

			var g : Graphics = sp.graphics;
			var bmd : BitmapData = InspectorSymbolIcon.getIcon(InspectorSymbolIcon.LOGO);
			g.beginBitmapFill(bmd, new Matrix(1, 0, 0, 1, (23 - bmd.width) / 2, (23 - bmd.height) / 2), false);
			g.drawRect((23 - bmd.width) / 2, (23 - bmd.height) / 2, bmd.width, bmd.height);
			g.endFill();

			return sp;
		}
	}
}
