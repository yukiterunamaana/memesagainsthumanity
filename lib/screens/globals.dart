import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class Globals
{
  //static var channel;
  static WebSocketChannel? channel;
  static bool isWebsocketRunning = false;

  static connect(address) {
    channel = IOWebSocketChannel.connect(address);
    channel!.stream.listen(
          (event) {
        //_setData(json.decode(event));
        print(event);
      },
      onDone: () {
        isWebsocketRunning = false;
      },
      onError: (err) {
        isWebsocketRunning = false;
        connect(address);
      },
    );
  }
}