import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

late IO.Socket socket;

const String _name = 'OtherUser (0)';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class ChatMessage extends StatelessWidget {
  final String text;
  final String username;
  final bool isSent;

  String score="0";
  /*
  * final bool isPrompt;
  * final string??? image;
  * */

  ChatMessage({
    required this.text, //or image???
    required this.username,
    required this.isSent,
    //required this.isPrompt,
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
                Visibility(
                  visible: isSent,
                  child: Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                              score = updateScore(2);
                            },
                          child: Text('+2'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: (isSent)?Colors.black:Colors.red,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            score = updateScore(1);
                          },
                          child: Text('+1'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: (isSent)?Colors.black:Colors.red,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            score = updateScore(-1);
                          },
                          child: Text('-1'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: (isSent)?Colors.black:Colors.red,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            score = updateScore(-2);
                          },
                          child: Text('-2'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: (isSent)?Colors.black:Colors.red,
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0),
                          child:Text(
                              score.toString(),
                          )
                        ),
                      ],
                    ),
                ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String updateScore(int r)
  {
    return (int.parse(score)+r).toString();
  }
}
//TODO make chat messages stateful to update scores
/*
class ChatMessageState extends StatefulWidget
{
  final String text;
  final String username;
  final bool isSent;

  String score="0";
  /*
  * final bool isPrompt;
  * final string??? image;
  * */

  ChatMessage({
    required this.text, //or image???
    required this.username,
    required this.isSent,
    //required this.isPrompt,
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
                Visibility(
                  visible: isSent,
                  child: Container(
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            score = updateScore(2);
                          },
                          child: Text('+2'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: (isSent)?Colors.black:Colors.red,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            score = updateScore(1);
                          },
                          child: Text('+1'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: (isSent)?Colors.black:Colors.red,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            score = updateScore(-1);
                          },
                          child: Text('-1'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: (isSent)?Colors.black:Colors.red,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            score = updateScore(-2);
                          },
                          child: Text('-2'),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: (isSent)?Colors.black:Colors.red,
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(10.0),
                            child:Text(
                              score.toString(),
                            )
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String updateScore(int r)
  {
    return (int.parse(score)+r).toString();
  }
}
*/

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
      // appBar: AppBar(
      //   title: Text(
      //     'Chat App', //TODO выдавать номер комнаты!
      //   ),
      // ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 20.0, right: 0), // Or adjust the values to your preference
        child: Align(
          alignment: Alignment.topRight,
          child: IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Do something when the IconButton is pressed
              showAlertDialog(context);
            },
          ),
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
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
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

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Text("Exit game?"),
      actions: [
        TextButton(
          child: Text("No"),
          onPressed: () {
            Navigator.of(context).pop(); // Close the alert dialog
          },
        ),
        TextButton(
          child: Text("Yes"),
          onPressed: () {
            Navigator.of(context).pop(); // Close the alert dialog
            Navigator.of(context).pushReplacementNamed('/'); // Navigate to the main screen
          },
        ),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

