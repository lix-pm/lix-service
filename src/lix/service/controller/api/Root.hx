package lix.service.controller.api;

import why.fs.FilesApi as Files;

class Root extends Base implements lix.service.api.controller.Root {
	public function haxe():lix.service.api.controller.Haxe return new Haxe();
	public function lix():lix.service.api.controller.Lix return new Lix();
	public function files():Files return new Files(fs);
}