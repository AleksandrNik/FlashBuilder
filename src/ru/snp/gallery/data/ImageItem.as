package ru.snp.gallery.data {
	public class ImageItem {
		private var _id:uint;
		private var _title:String;
		private var _url:String;
		
		public function ImageItem(id:uint, title:String, url:String) {
			_id = id;
			_title = title;
			_url = url;
		}

		// properties:
		public function get id():uint {
			return _id;
		}
		
		public function get title():String {
			return _title;
		}
		
		public function get url():String {
			return _url;
		}
	}
}