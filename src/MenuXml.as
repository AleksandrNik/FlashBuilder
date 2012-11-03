package {
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import ru.snp.gallery.data.ImageItem;
	import ru.snp.gallery.gui.GalleryView;
	import ru.snp.gallery.gui.MenuButton;

	[SWF(width = "800", height = "600", backgroundColor = "0xCCCCCC")]
	public class MenuXml extends Sprite {
		static private const XML_PATH:String = "site.xml";
		static private const BUTTON_SPACE:uint = 12;

		private var _settingsXML:XML;
		private var _buttons:Vector.<MenuButton>;
		private var _galleryView:GalleryView;
		private var _currentButton:MenuButton;
		private var _loader:URLLoader;

		public function MenuXml() {
			var request:URLRequest = new URLRequest(XML_PATH);

			_loader = new URLLoader();
			_loader.load(request);
			_loader.addEventListener(Event.COMPLETE, xmlLoadedHandler);
		}

		// private:
		private function createMenu():void {
			var container:Sprite = new Sprite;
			addChild(container);

			var buttonX:uint = 0;

			_buttons = new Vector.<MenuButton>;
			for each (var link:XML in _settingsXML.links.link) {
				var item:ImageItem = xmlToImageItem(link);
				var button:MenuButton = new MenuButton(item);
				button.x = buttonX;
				container.addChild(button);
				_buttons.push(button);

				buttonX += button.width + BUTTON_SPACE;
				button.addEventListener(MouseEvent.CLICK, mouseClickHandler, false, 0, true);
			}
			
			container.x = (stage.stageWidth - container.width) / 2;
			container.y = (stage.stageHeight / 100) * 15;
			
			_galleryView = new GalleryView;
			_galleryView.y = 300;
			addChild(_galleryView);
			selectButton(_buttons[0]);
		}
		
		private function xmlToImageItem(xml:XML):ImageItem {
			var id:uint = xml.@id;
			var title:String = xml.@title;
			var url:String = xml.@url;
			var item:ImageItem = new ImageItem(id, title, url);
			return item;
		}
		
		private function selectButton(button:MenuButton):void {
			if (button != _currentButton) {
				var item:ImageItem = button.item;
				if (_currentButton) {
					_currentButton.select = false;
				}
				_currentButton = button;
				_currentButton.select = true;
				_galleryView.showItem(button.item);
			}
		}

		// handlers:
		protected function xmlLoadedHandler(event:Event):void {
			if (_loader) {
				_settingsXML = new XML(_loader.data);
				_settingsXML.ignoreWhitespace = true;
				createMenu();
			}
		}

		protected function mouseClickHandler(event:MouseEvent):void {
			var button:MenuButton = event.target as MenuButton;
			if (button) {
				selectButton(button);
			}
		}
	}
}
