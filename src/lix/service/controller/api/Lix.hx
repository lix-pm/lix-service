package lix.service.controller.api;

import js.node.ChildProcess.spawn;
import tink.core.ext.Promises;

using tink.io.Source;

class Lix extends Base implements lix.service.api.controller.Lix {
	public function run(args:Array<String>):Promise<{code:Int, stdout:String, stderr:String}> {
		var proc = spawn('lix', args, {cwd: Config.STORAGE_FOLDER});
		return Promises.multi({
			code: (Future.async(cb -> proc.on('exit', (code, signal) -> cb(code))):Future<Int>),
			stdout: Source.ofNodeStream('stdout', proc.stdout).all().next(chunk -> chunk.toString()),
			stderr: Source.ofNodeStream('stderr', proc.stderr).all().next(chunk -> chunk.toString()),
		});
	}
}