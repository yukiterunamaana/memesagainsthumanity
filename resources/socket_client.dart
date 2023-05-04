import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClient
{
  IO.Socket? socket;
  static SocketClient? _inst;

  SocketClient._internal()
  {
    socket = IO.io('http://188.93.67.142:3000',
    <String,dynamic>
    {
      'transports': ['websocket'],
      'autoConnect': false,
    }
    );
    socket!.connect();
  }
  static SocketClient get inst
  {
    _inst ??=SocketClient._internal();
    return _inst!;
  }
}