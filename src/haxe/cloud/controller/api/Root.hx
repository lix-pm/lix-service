package haxe.cloud.controller.api;

import why.fs.FilesApi as Files;

class Root extends Base implements haxe.cloud.api.controller.Root {
	public function haxe():haxe.cloud.api.controller.Haxe return new Haxe();
	public function lix():haxe.cloud.api.controller.Lix return new Lix();
	public function files():Files return new Files(fs);
}