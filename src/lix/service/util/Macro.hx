package lix.service.util;

import haxe.macro.Context;

class Macro {
	public static macro function getBuildDate() {
		var now = Date.now().getTime();
		return macro Date.fromTime($v{now});
	}
	
	public static macro function getGitSha() {
		#if !display
			var process = new sys.io.Process('git', ['rev-parse', 'HEAD']);
			return if (process.exitCode() != 0)
				macro Sys.getEnv('CI_COMMIT_SHA');
			else 
				macro $v{process.stdout.readLine()};
		#else 
			// `#if display` is used for code completion. In this case returning an
			// empty string is good enough; We don't want to call git on every hint.
			return macro '';
		#end
	}
	
	public static macro function getDefine(name:String)
		return macro $v{Context.definedValue(name)}
}