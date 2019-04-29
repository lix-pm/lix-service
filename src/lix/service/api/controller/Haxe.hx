package lix.service.api.controller;

interface Haxe {
	@:post('/')
	@:params(args in body)
	function run(args:Array<String>):Promise<{code:Int, stdout:String, stderr:String}>;
}