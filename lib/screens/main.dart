import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'communication.dart';
import 'globals.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {

  WebSocketChannel channel = IOWebSocketChannel.connect("wss://ws.ifelse.io/");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {

  @override
  MyHomePageState createState() {
    return MyHomePageState();
  }
}
class MyHomePageState extends State<MyHomePage> {
  //const MyScreen({super.key});
  TextEditingController nicknameController = new TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nicknameController.dispose();
    super.dispose();
  }

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
                      onPressed: () {player.roomID=1;},
                      child: Text('1'),
                    ),
                    ElevatedButton(
                      onPressed: () {player.roomID=2;},
                      child: Text('2'),
                    ),
                    ElevatedButton(
                      onPressed: () {player.roomID=3;},
                      child: Text('3'),
                    ),
                    ElevatedButton(
                      onPressed: () {player.roomID=4;},
                      child: Text('4'),
                    ),
                    ElevatedButton(
                      onPressed: () {player.roomID=5;},
                      child: Text('5'),
                    ),
                  ],
                ),
              )
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: nicknameController,
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
                Globals.connect(ourwebsocket);
                //WebSocketChannel channel = IOWebSocketChannel.connect(ourwebsocket);
                player.name=nicknameController.text;
                if (player.name != "" && player.roomID != -1) {
                  final json = {"nickname":player.name,"room_id":player.roomID};
                  final encodedJSON = jsonEncode(json);
                  sendMessage(encodedJSON);
                }
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

  void sendMessage(msg) {
    IOWebSocketChannel? channel;
    try {
      channel = IOWebSocketChannel.connect(ourwebsocket);
    } catch (e) {
      print("Error on connecting to websocket: " + e.toString());
    }
    channel?.sink.add(msg);
    channel?.stream.listen((event) {
      if (event!.isNotEmpty)
      {
        print(jsonDecode(event));
        channel!.sink.close();
      }
    });
  }

}