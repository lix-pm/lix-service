package lix.service.api.controller;

import why.fs.FilesApi as Files;

interface Root {
	@:sub function haxe():Haxe;
	@:sub function lix():Lix;
	@:sub function files():Files;
}