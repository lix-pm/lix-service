package haxe.cloud.controller.api;

import why.fs.Local;
import tink.http.Method;

class Base {
	static inline var API_SERVER_URL = 'TODO';
	
	var fs = new Local({
		root: Config.STORAGE_FOLDER,
		getDownloadUrl: (path, _) -> {
			url: '$API_SERVER_URL/files?path=$path',
			headers: [],
			method: GET,
		},
		getUploadUrl: (path, _) -> {
			url: '$API_SERVER_URL/files?path=$path',
			headers: [],
			method: PUT,
		},
	});
	
	public function new() {}
}