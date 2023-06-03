import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
String ourwebsocket="ws://localhost:9000";
class Globals
{
  //static var channel;
  static WebSocketChannel? channel;
  static bool isWebsocketRunning = false;

  static connect(address) {
    channel = IOWebSocketChannel.connect(address);
    channel!.stream.listen(
          (event) {
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
class Player
{
  int roomID = -1;
  String name = "";
}
Player player = Player();