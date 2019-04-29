package haxe.cloud.controller.api;

import jsonrpc.Types;
import jsonrpc.Protocol;
import tink.websocket.ServerHandler;
import tink.websocket.RawMessageStream;
import tink.websocket.RawMessage;
import tink.streams.Stream;

class LanguageServer extends Base implements haxe.cloud.api.controller.LanguageServer {
	
	static var server = new HaxeLanguageServer();
	
	public function restart():Promise<Noise> {
		server = new HaxeLanguageServer();
		return Noise;
	}
	
	public function message(msg:RequestMessage):Promise<ResponseMessage> {
		return server.request(msg);
	}
}

private class HaxeLanguageServer {
	public static function handle(incoming:Incoming):RawMessageStream<Noise> {
		var responses = Signal.trigger();
		var protocol = new Protocol(msg -> responses.trigger(cast msg));
		var outgoing = Signal.trigger();
		
		function request(str:String) {
			switch tink.Json.parse((str:RequestMessage)) {
				case Success(msg):
					responses.asSignal().nextTime(m -> m.id == msg.id).handle(res -> outgoing.trigger(Data(Text(haxe.Json.stringify(res)))));
					protocol.handleMessage(msg);
				case Failure(e): trace(e);
			}
		}
		
		incoming.stream.forEach(raw -> {
			switch raw {
				case Text(v): request(v);
				case Binary(b): request(b);
				case ConnectionClose: // TODO: kill server
				case Ping(b): outgoing.trigger(Data(Pong(b)));
				case Pong(b): 
			}
			Resume;
		}).handle(function(o) switch o {
			case Halted(_): // unreachable
			case Failed(e): trace(e);
			case Depleted: // TODO clean up protocol
		});
		
		return new SignalStream(outgoing);
	}
}