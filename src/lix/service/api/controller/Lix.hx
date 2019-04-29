package lix.service.api.controller;

interface Lix {
	@:post
	@:params(args in body)
	function run(args:Array<String>):Promise<{code:Int, stdout:String, stderr:String}>;
}