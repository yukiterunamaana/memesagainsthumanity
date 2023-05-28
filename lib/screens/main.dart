import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import 'communication.dart';
import 'globals.dart';
void main() {
  runApp(new MyApp());
  Globals.connect("ws://127.0.0.1:9000");
}

class MyApp extends StatelessWidget {

  WebSocketChannel channel = IOWebSocketChannel.connect("wss://ws.ifelse.io/");
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
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