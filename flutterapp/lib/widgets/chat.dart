// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:socket_io_client/socket_io_client.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Socket socket;

  @override
  void initState() {
    super.initState();
    connectToServer();
  }

  void connectToServer() {
    try {
      // Configure socket transports must be sepecified
      socket = io('http://127.0.0.1:3000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
      });

      // Connect to websocket
      socket.connect();

      // Handle socket events
      socket.on('connect', (_) => print('connect: ${socket.id}'));
      socket.on('location', handleLocationListen);
      socket.on('typing', handleTyping);
      socket.on('message', handleMessage);
      socket.on('disconnect', (_) => print('disconnect'));
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      print(e.toString());
    }
  }

  // Send Location to Server
  void sendLocation(Map<String, dynamic> data) {
    socket.emit('location', data);
  }

  // Listen to Location updates of connected usersfrom server
  void handleLocationListen(Map<String, dynamic> data) async {
    print(data);
  }

  // Send update of user's typing status
  void sendTyping(bool typing) {
    socket.emit('typing', {
      'id': socket.id,
      'typing': typing,
    });
  }

  // Listen to update of typing status from connected users
  void handleTyping(Map<String, dynamic> data) {
    print(data);
  }

  // Send a Message to the server
  void sendMessage(String message) {
    socket.emit(
      'message',
      {
        'id': socket.id,
        'message': message, // Message to be sent
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      },
    );
  }

  // Listen to all message events from connected users
  void handleMessage(Map<String, dynamic> data) {
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
