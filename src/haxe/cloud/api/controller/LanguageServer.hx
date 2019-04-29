package haxe.cloud.api.controller;

import jsonrpc.Types;

interface LanguageServer {
	@:post
	function restart():Promise<Noise>;
	
	@:post
	@:consumes('application/json')
	function message(body:RequestMessage):Promise<ResponseMessage>;
}