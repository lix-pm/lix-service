package lix.service;

import tink.http.Response.OutgoingResponse;
import tink.http.Handler;
import tink.http.containers.NodeContainer;
import tink.http.middleware.Log;
import tink.web.routing.*;
import lix.service.api.controller.Root as Interface;
import lix.service.controller.api.Root as Impl;

class Controller {
	static function main() {
		trace(lix.service.util.Macro.getBuildDate());
		trace(lix.service.util.Macro.getGitSha());
		
		var router = new Router<Interface>(new Impl());
		
		var port = switch Sys.getEnv('PORT') {
			case null: 8082;
			case v: Std.parseInt(v);
		}
		
		var handler:Handler = req -> router.route(Context.ofRequest(req)).recover(OutgoingResponse.reportError);
		handler = handler.applyMiddleware(new Log());
		
		new NodeContainer(port).run(handler).handle(o -> trace(o.getName()));
	}
}
