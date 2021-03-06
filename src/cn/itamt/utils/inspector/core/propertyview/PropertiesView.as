package cn.itamt.utils.inspector.core.propertyview {
	import cn.itamt.utils.inspector.core.BaseInspectorPlugin;
	import cn.itamt.utils.inspector.core.IInspector;
	import cn.itamt.utils.inspector.core.InspectTarget;
	import cn.itamt.utils.inspector.core.propertyview.accessors.ObjectPropertyEditor;
	import cn.itamt.utils.inspector.core.propertyview.accessors.PropertyAccessorRender;
	import cn.itamt.utils.inspector.events.PropertyEvent;
	import cn.itamt.utils.inspector.output.InspectorOutPuterManager;
	import cn.itamt.utils.inspector.plugins.InspectorPluginId;
	import cn.itamt.utils.inspector.popup.InspectorPopupManager;
	import cn.itamt.utils.inspector.popup.PopupAlignMode;
	import cn.itamt.utils.inspector.ui.InspectorStageReference;
	import flash.geom.Point;

	import flash.display.DisplayObject;
	import flash.events.Event;

	/**
	 * tInspector的属性视图
	 * @author itamt@qq.com
	 */
	public class PropertiesView extends BaseInspectorPlugin {
		private var _size:Point = new Point(250, 280);
		public function set size(pt:Point):void {
			_size = pt.clone();
		}
		public function get size():Point {
			return _size;
		}
		
		private var panels : Array;

		public function PropertiesView() {
			super();
		}

		override public function set outputerManager(value : InspectorOutPuterManager) : void {
			trace('[PropertiesView][outputerManager]PropertiesView没有设计信息输出的接口，忽略该属性设置。');
		}

		override public function getPluginId() : String {
			return InspectorPluginId.PROPER_VIEW;
		}

		override public function onRegister(inspector : IInspector) : void {
			super.onRegister(inspector);
			
			_icon = new PropertiesViewButton();
		}

		override public function contains(child : DisplayObject) : Boolean {
			if(panels) {
				var l : int = panels.length;
				for(var i : int = 0;i < l;i++) {
					if(panels[i] == child || panels[i].contains(child)) {
						return true;
					}
				}
			}
			
			return false;
		}

		/**
		 * 显示面板
		 */
		override public function onActive() : void {
			super.onActive();
			
			if(this.panels == null)this.panels = [];
			
			var panel : DisplayObjectPropertyPanel = new DisplayObjectPropertyPanel(size.x, size.y);
			this.panels.push(panel);
			InspectorPopupManager.popup(panel, PopupAlignMode.CENTER);
			panel.addEventListener(Event.CLOSE, onClickClose, false, 0, true);
			panel.addEventListener(PropertyEvent.UPDATE, onPropertyUpdate);
			
			this._inspector.stage.addEventListener(PropertyEvent.INSPECT, onInspectProperty);
		}

		private function onInspectProperty(evt : PropertyEvent) : void {
			if(evt.target is ObjectPropertyEditor) {
				var accessor : PropertyAccessorRender = (evt.target as ObjectPropertyEditor).parent as PropertyAccessorRender;
				var target : * = (evt.target as ObjectPropertyEditor).getValue();
//				if(target is DisplayObject) {
//					_inspector.inspect(target as DisplayObject);
//				} else {
				for each(var panel:PropertyPanel in this.panels) {
					if(!(panel is DisplayObjectPropertyPanel)) {
						if(panel.getSingleMode()) {
							panel.onInspect((evt.target as ObjectPropertyEditor).getValue());
							return;
							break;
						}
					}
				}
				panel = new PropertyPanel(size.x, size.y, accessor);
				this.panels.push(panel);
				panel.addEventListener(Event.CLOSE, onClickClose, false, 0, true);
				this._inspector.stage.addChild(panel);
				panel.onInspect(target);
				
				InspectorStageReference.centerOnStage(panel);
			}
//			}
		}

		/**
		 * 当取消在Inspector的注册时.
		 */
		override public function onUnActive() : void {
			super.onUnActive();
			
			if(panels) {
				for each(var panel:DisplayObjectPropertyPanel in panels) {
					InspectorPopupManager.remove(panel);
				}
			}
			
			this.panels = null;
			this._inspector.stage.removeEventListener(PropertyEvent.INSPECT, onInspectProperty);
		}

		/**
		 * 查看对象时
		 */		
		override public function onInspect(target : InspectTarget) : void {
			super.onInspect(target);
			
			for each(var panel:PropertyPanel in this.panels) {
				if(panel is DisplayObjectPropertyPanel) {
					if(panel.getSingleMode()) {
						panel.onInspect(target.displayObject);
						return;
						break;
					}
				}
			}
			
			panel = new DisplayObjectPropertyPanel(size.x, size.y);
			this.panels.push(panel);
			
			this._inspector.stage.addChild(panel);
			panel.addEventListener(Event.CLOSE, onClickClose, false, 0, true);
			panel.addEventListener(PropertyEvent.UPDATE, onPropertyUpdate);
			panel.onInspect(target.displayObject);
		}

		/**
		 * 实时查看对象时
		 */		
		override public function onLiveInspect(target : InspectTarget) : void {
			//实现置顶
			//DisplayObjectTool.swapToTop(this.panel);
		}

		/**
		 * 对象有更新时
		 */
		override public function onUpdate(target : InspectTarget = null) : void {
			for each(var panel:PropertyPanel in this.panels) {
				if(panel.getSingleMode() || panel.getCurTarget() == target.displayObject) {
					panel.onInspect(target.displayObject);
				}
			}
		}

		//////////////////////////////////////
		//////////private functions///////////
		//////////////////////////////////////

		private function onPropertyUpdate(event : PropertyEvent) : void {
			this._inspector.updateInsectorView();
		}

		/**
		 * 玩家单击关闭按钮时
		 */
		private function onClickClose(evt : Event) : void {
			var panel : PropertyPanel = evt.target as PropertyPanel;
			var t : int = this.panels.indexOf(panel);
			if(t > -1) {
				this.panels.splice(t, 1);
				InspectorPopupManager.remove(panel);
			}
			
			if(this.panels.length == 0) {
				this._inspector.pluginManager.unactivePlugin(InspectorPluginId.PROPER_VIEW);
			}
		}
	}
}
