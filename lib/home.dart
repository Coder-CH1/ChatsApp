import 'package:chatsapp/profile.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  late IO.Socket socket;

  void initSocket() {
  super.initState();
  socket = IO.io('http://localhost:3001', IO.OptionBuilder()
      .setTransports(['websocket'])
      .enableAutoConnect()
      .build()
  );
  socket.on('connect', (_) {
    print('connected to server');
  });

  socket.on('message', (data) {
    print('connected to server');
    _handleMessage(data);
  });

  socket.on('disconnect', (_) {
    print('disconnected from server');
  });
}

  @override

  void sendMessage(String message) {
    socket.emit('message', message);
  }
  void _handleMessage(dynamic message) {
    setState(() {
      _messages.add(message);
    });
  }
  List<String> _messages = [];
  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFE81D),
        title: Text('Chat'),
        leading: IconButton(
          icon: Icon(Icons.person, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Profile(userId: '')),
            );
          },
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Color(0xFF00F0FF),
                  onPressed: () {
                    Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 15, left: 15, right: 15),
                    child: Column(
                    children: <Widget>[
                    TextField(
                    //controller: messageController,
                    decoration: InputDecoration(
                    labelText: 'Enter your message',
                    ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                    onPressed: () {},
                    child: Text('Send Message'),
                    ),
                    ],
                    ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}