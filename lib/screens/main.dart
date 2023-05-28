import 'dart:io';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:web_socket_channel/io.dart';
import 'globals.dart';

late IO.Socket socket;


void main() async {
  Socket sock = await Socket.connect('127.0.0.1', 9000);
  runApp(new MyApp(sock));
}

class MyApp extends StatelessWidget {
  //
  late Socket socket;

  MyApp(Socket s) {
    this.socket = s;
  }
  //

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: MyHomePage(channel: socket),
    );
  }
}
class MyHomePage extends StatefulWidget {
  late Key key;
  late final Socket channel;
  MyHomePage({key, required this.channel})
      : super(key: key);

  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}
class MyHomePageState extends State<MyHomePage> {
  //const MyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.help),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: Text("Made in 2023 as a term project!"),
                  );
                },
              );
            }
          ),
        ],
        title: Text('Memes against Humanity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: const EdgeInsets.all(16.0),
              child:
              Container(
                height: 50.0,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('1'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('2'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('3'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('4'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('5'),
                    ),
                  ],
                ),
              )
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your nickname',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            ElevatedButton.icon(
              icon: Icon(Icons.check),
              label: Text('Enter/Create game session'),
              onPressed: () {
                WebSocketChannel channel = IOWebSocketChannel.connect("ws://127.0.0.1:9000");
                //TODO переписать логику (см. индийский туториал 1:02:34)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatScreen()),
                );
              },
            ),
          ],
        ),
      ),
      )
    );
  }
}

const String _name = 'OtherUser (0)';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class ChatMessage extends StatelessWidget {
  final String text;
  final String username;
  final bool isSent;

  ChatMessage({
    required this.text,
    required this.username,
    required this.isSent,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = isSent
        ? BorderRadius.only(
      topLeft: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
    )
        : BorderRadius.only(
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(16.0),
      bottomRight: Radius.circular(16.0),
    );

    final Color color = isSent ? Colors.white : Colors.blue;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 16.0),
            // child: CircleAvatar(
            //   child: Text(
            //     username.substring(0, 1),
            //   ),
            // ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  username,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: radius,
                  ),
                  padding: EdgeInsets.all(10.0),
                  child: Text(text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  bool _isComposing = false;

  @override
  void initState() {
    socket = IO.io('http://localhost:9000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Chat App'
        ),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (_, int index) => _messages[index],
            ),
          ),
          Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.photo_camera),
                onPressed: () {
                  // TODO: implement sending images
                },
              ),
            ),
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (String text) {
                  setState(() {
                    _isComposing = text.length > 0;
                  });
                },
                onSubmitted: _handleSubmitted,
                decoration:
                InputDecoration.collapsed(hintText: 'Enter your message'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing
                    ? () => _handleSubmitted(_textController.text)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      text: text,
      username: 'User (0)',
      isSent: true,
    );
    setState(() {
      _messages.insert(0, message);
    });
  }

// void _sendMessage() {
//   if (_controller.text.isNotEmpty) {
//     widget.channel.write(_controller.text);
//   }
// }
//
// @override
// void dispose() {
//   widget.channel.close();
//   super.dispose();
// }

}