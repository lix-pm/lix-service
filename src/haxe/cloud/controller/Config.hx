package haxe.cloud.controller;

using haxe.io.Path;

class Config {
	public static var STORAGE_FOLDER = Path.join([Sys.programPath().directory(), 'storage']);
	
}