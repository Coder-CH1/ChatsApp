import 'package:chatsapp/profile.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  late IO.Socket socket;
  final List<String> _messages = [];
  final TextEditingController _messagesController = TextEditingController();
  final String displayName = 'User1';
  final String recipientName = 'User2';

  @override
  void initState() {
    super.initState();
        initSocket();
  }

  void initSocket() {
  socket = IO.io('http://localhost:3001', IO.OptionBuilder()
      .setTransports(['websocket'])
      .enableAutoConnect()
      .build()
  );
  socket.on('connect', (_) {
    print('connected to server');
    socket.emit('register', displayName);
  });

  socket.on('private_message', (data) {
    print('connected to server');
    setState(() {
      _messages.add('${data['message']}: ${data['message']}');
    });
  });

  socket.on('disconnect', (_) {
    print('disconnected from server');
  });
}

void _sendMessages() {
    final msg = _messagesController.text;
    if (msg.isNotEmpty) {
      socket.emit('private_message', {
        'to', recipientName,
        'message', msg,
      });
      setState(() {
        _messages.add('Me $msg');
        _messagesController.clear();
      });
    }
}

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFE81D),
        title: const Text('Chat', style: TextStyle(
          fontFamily: 'Caros',
          color: Colors.black54,
          fontWeight: FontWeight.bold,
        )
        ),
        leading: IconButton(
          icon: const Icon(Icons.person, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Profile(userId: '')),
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
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Enter your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: const Color(0xFF00F0FF),
                  onPressed: () {
                    _sendMessages();
                    Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 15, left: 15, right: 15),
                    child: Column(
                    children: <Widget>[
                    TextField(
                    controller: _messagesController,
                    decoration: const InputDecoration(
                    labelText: 'Enter your message',
                    ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                    onPressed: () {},
                    child: const Text('Send Message'),
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