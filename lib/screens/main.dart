import 'package:flutter/material.dart';
import 'communication.dart';
import 'package:memesagainsthumanity/resources/socket_methods.dart';
import 'package:custom_button/custom_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyScreen(),
    );
  }
}

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});
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
          // IconButton(
          //   icon: Icon(Icons.settings),
          //   onPressed: () {
          //     Navigator.push(context, MaterialPageRoute(builder: (context) {
          //       return SettingsScreen();
          //     }));
          //   }
          // ),
        ],
        title: Text('Memes against Humanity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(16.0),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       labelText: 'Enter room ID if you have one',
            //       border: OutlineInputBorder(),
            //     ),
            //   ),
            // ),

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
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home:Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           title: Text('Settings'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               CheckboxListTile(
//                 title: Text('Allow offensive actions and content'),
//                 value: false,
//                 onChanged: (newValue) {
//                   // Do something with the new value
//                 },
//               ),
//               CheckboxListTile(
//                 title: Text('Checkbox 2'),
//                 value: false,
//                 onChanged: (newValue) {
//                   // Do something with the new value
//                 },
//               ),
//             ],
//           ),
//         ),
//       )
//     );
//   }
// }