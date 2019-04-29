package haxe.cloud;

import haxe.cloud.api.controller.Root;
import tink.http.clients.NodeClient;
import tink.web.proxy.Remote;
import tink.url.Host;
import why.fs.Local;

using tink.io.Source;
using haxe.io.Path;

class Client {
	static function main() {
		new Client().run();
	}
	
	static var ROOT = Path.join([Sys.programPath().directory(), 'example']);
	
	var fs = new Local({root: ROOT});
	
	function new() {}
	
	var remote = {
		var port = switch Sys.args() {
			case [v]: Std.parseInt(v);
			case v: trace(v); 8080;
		}
		new Remote<Root>(new NodeClient(), new Host('localhost', port));
	}
	
	function run() {
		// upload sources
		// run lix download
		// complile haxe
		// download output
		// run in iframe
		return uploadAll()
			.next(res -> lix()).next(log)
			.next(res -> haxe()).next(log)
			.next(res -> download())
			.next(res -> res.body.all())
			.handle(o -> trace(o.sure().toString()));
	}
	
	function log<T>(v:T):Promise<T> {
		trace(v);
		return v;
	}
	
	function uploadAll() {
		return fs.list('.').next(files -> {
			var promises = [];
			for (entry in files) {
				if(entry.type == File) promises.push(upload(entry.path));
			}
			return Promise.inParallel(promises);
		});
	}
	
	function upload(path:String) {
		return remote.files().upload(path, fs.read(path));
	}
	
	function lix() {
		return remote.lix().run(['download']);
	}
	
	function haxe() {
		return remote.haxe().run('-cp src -js bin/index.js -main Main'.split(' '));
	}
	
	function download() {
		return remote.files().download('bin/index.js');
	}
}