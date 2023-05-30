import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'communication.dart';
import 'globals.dart';

String ourwebsocket="ws://localhost:9000";

class Player
{
  int roomID = -1;
  String name = "";
}

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
  Player player = new Player();
  TextEditingController nicknameController = new TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nicknameController.dispose();
    super.dispose();
  }
  //
  // Flex roomButtonRow = Flex(
  //   direction: Axis.horizontal,
  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //   children: [
  //     ElevatedButton(
  //       onPressed: () {player.roomID=1;},
  //       child: Text('1'),
  //     ),
  //     ElevatedButton(
  //       onPressed: () {player.roomID=2;},
  //       child: Text('2'),
  //     ),
  //     ElevatedButton(
  //       onPressed: () {player.roomID=3;},
  //       child: Text('3'),
  //     ),
  //     ElevatedButton(
  //       onPressed: () {player.roomID=4;},
  //       child: Text('4'),
  //     ),
  //     ElevatedButton(
  //       onPressed: () {player.roomID=5;},
  //       child: Text('5'),
  //     ),
  //   ],
  // );


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

                if (player.name!=null && player.roomID != -1) {
                  final json = {"nickname":player.name,"room_id":player.roomID};
                  final encodedJSON = jsonEncode(json);
                  sendMessage(encodedJSON);
                  //sendMessage(_message);
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

  void selectRoom(int r)
  {
    player.roomID=r;
  }

  void sendMessage(msg) {
    IOWebSocketChannel? channel;
    // We use a try - catch statement, because the connection might fail.
    try {
      // Connect to our backend.
      channel = IOWebSocketChannel.connect(ourwebsocket);
    } catch (e) {
      // If there is any error that might be because you need to use another connection.
      print("Error on connecting to websocket: " + e.toString());
    }
    // Send message to backend
    channel?.sink.add(msg);
    // Listen for any message from backend

    // channel?.stream.listen((event) {
    //   // Just making sure it is not empty
    //   if (event!.isNotEmpty)
    //   {
    //     print(jsonDecode(event));
    //     // Now only close the connection and we are done here!
    //     channel!.sink.close();
    //   }
    // });
  }

  //TODO
  void sendReaction(msg,type) {}
  void cancelReaction(msg,type) {}
}