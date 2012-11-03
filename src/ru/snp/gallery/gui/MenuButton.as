package ru.snp.gallery.gui {
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import ru.snp.gallery.data.ImageItem;
	

	public class MenuButton extends Sprite {
		private var _tf:TextField;
		private var _hover:Sprite;
		private var _select:Boolean = false;
		
		private var _item:ImageItem;

		public function MenuButton(item:ImageItem) {
			_item = item;
			setupUI();
		}

		// properties:
		public function get item():ImageItem {
			return _item;
		}

		//public:
		public function set select(value:Boolean):void {
			
			_select = value;
			if (_select == false)
			{
				TweenMax.to(_hover, 0, {tint: 0xFF0000});
			} else {
				TweenMax.to(_hover, 0.2, {tint: 0xFFFFFF});
			}
		}
		
		// private:
		private function setupUI():void {
			buttonMode = true;
			mouseChildren = false;


			_tf = new TextField;
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.text = _item.title.toUpperCase();
			addChild(_tf);

			_hover = new Sprite;
			
			_hover.graphics.beginFill(0xFF0000);
			_hover.graphics.drawRect(0, 0, _tf.textWidth + 20, _tf.textHeight + 10);
			_hover.graphics.endFill();
			addChildAt(_hover, 0);
			

			_tf.x = (width - _tf.width) / 2;
			_tf.y = (height - _tf.height) / 2;
			addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler, false, 0, true);
			
		}

		// handlers:
		protected function mouseOverHandler(event:MouseEvent):void {
			TweenMax.to(_hover, 1, {scaleY: 1.5, ease: Elastic.easeOut});
		}

		protected function mouseOutHandler(event:MouseEvent):void {
			TweenMax.to(_hover, 1, {scaleY: 1, ease: Elastic.easeOut});
		}
		
	}
}
