package ru.snp.gallery.gui {
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Linear;
	import com.greensock.events.TweenEvent;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import flashx.textLayout.formats.LineBreak;
	
	import org.osmf.media.LoadableElementBase;
	
	import ru.snp.gallery.data.ImageItem;
	
	public class GalleryView extends Sprite {
		
		private var _loader1:Loader;
		private var _container:MovieClip;
		private var _containerOld:MovieClip;
		private var _contFlag:Number = 0;
		private var _itemId:uint;
		private var _itemLastId:uint;
		
		public function GalleryView() {
			
		}
		
		// public:
		public function showItem(item:ImageItem):void {
			
			_container = new MovieClip;
			_container.x = stage.stageWidth/3;
			_container.y = 0 - stage.stageHeight/4;
			_container.graphics.beginFill(0xCCCCCC,1);
			_container.graphics.drawRect(-500,0,900,300);
			addChild(_container);
			
			if (_contFlag == 0){
				_containerOld = new MovieClip;
				_containerOld.x = stage.stageWidth/3;
				_containerOld.y = 0 - stage.stageHeight/4;
				addChild(_containerOld);
				_contFlag = 1;			
			}
			
			_loader1 = new Loader;			
			_loader1.load(new URLRequest(item.url));	
			_itemId = item.id;
			_loader1.contentLoaderInfo.addEventListener(Event.COMPLETE,onCompleteHandler);
			
		}
		protected function onCompleteHandler(event:Event):void{
			if (_itemId >= _itemLastId) {
			_container.x = -500;
			_container.addChild(_loader1);
			TweenMax.to(_container,0.5, {x: 270, ease: Linear.easeInOut}).addEventListener(TweenEvent.COMPLETE, tweenCompleteHandler);
			TweenMax.to(_containerOld,0.5, {x: 900, ease: Linear.easeInOut});			
			} else {
				_container.x = 900;
				_container.addChild(_loader1);
				TweenMax.to(_container,0.5, {x: 270, ease: Linear.easeInOut}).addEventListener(TweenEvent.COMPLETE, tweenCompleteHandler);
				TweenMax.to(_containerOld,0.5, {x: -500, ease: Linear.easeInOut});			
			}
		}
		protected function tweenCompleteHandler(event:TweenEvent):void{
			
			_containerOld = _container;
			_itemLastId = _itemId;
			
		}
	}
}