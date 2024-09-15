import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:chat_project/models/connection.dart';
import 'package:chat_project/models/group.dart';
import 'package:chat_project/models/message.dart';
import 'package:chat_project/models/relationship.dart';
import 'package:chat_project/requests/group_request.dart';
import 'package:chat_project/requests/signin_request.dart';
import 'package:chat_project/requests/user_request.dart';
import 'package:chat_project/screens/splash.dart';
import 'package:chat_project/service_locator.dart';
import 'package:chat_project/services/auth_service_impl.dart';
import 'package:chat_project/services/group_service_impl.dart';
import 'package:chat_project/services/user_service_impl.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'domains/usecase/group/get_connection.dart';
import 'domains/usecase/login.dart';
import 'models/page_group.dart';
import 'models/user.dart';
import 'package:flutter_bcrypt/flutter_bcrypt.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
 // test();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}
void test() async {

  String username = 'user2'; // Replace with actual username
  String password = '123'; // Replace with actual password

  SigninRequest signinRequest = SigninRequest(username: username, password: password);
  final result = await sl<Login>().call(params: signinRequest);
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late Socket socket;
  StreamSubscription? socketSubscription;
  TextEditingController messageController = TextEditingController();
  TextEditingController chatController = TextEditingController();
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() async {
    final connection = await sl<GetConnection>().call(params: 4);
    socket = await Socket.connect(connection.IPv4, connection.port!);
    print("Connected to the server");

    // Initialize with the server (send InitObj)
    var initObj = {
      'creationDateTime': DateTime.now().toIso8601String(),
      "userName": 'user2',
      "message": "ddd"
    };
    sendObject(initObj);

    listenForMessages();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: TextField(
              controller: chatController,
              maxLines: null,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Chat messages",
              ),
            ),
          ),
          TextField(
            controller: messageController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Type your message...",
            ),
            onSubmitted: (value) {
              sendMessage(value);
              messageController.clear();
            },
          ),
        ],
      ),
    );
  }




  void sendMessage(String messageToSend) {
    if (socket != null && socket!.remoteAddress != null) {
      var messageObj = {
        'timestamp': DateTime.now().toIso8601String(),
        "username": 'user2',
        "message": messageToSend,
      };
      sendObject(messageObj);
      print("Sent: $messageToSend");
    }
  }

  // Serialize object and send it to the server
  void sendObject(Map<String, dynamic> obj) {
    if (socket != null && socket!.remoteAddress != null) {
      try {
        socket!.write(jsonEncode(obj) + '\n');
        socket!.flush();
      } catch (e) {
        print("Error sending message: $e");
        closeConnection();
      }
    }
  }


  // Listen for messages from the server (analogous to listenForMessage in Java)
  void listenForMessages() {
    if (socket != null) {
      socketSubscription = socket!.listen((data) {
        try {
          // Print raw byte data for debugging
          print("Raw data received: $data");

          // Attempt to decode the data
          String message = utf8.decode(data);
          print("Decoded message: $message");

          // Check if the message is valid JSON
          var decodedMessage = jsonDecode(message);
          print("Decoded JSON: ${decodedMessage}");

          // Process the decoded message
          if (decodedMessage['message'] != null) {
            chatController.text += "\n${decodedMessage['username']}: ${decodedMessage['message']}";
          } else if (decodedMessage['command'] != null) {
            handleCommand(decodedMessage['command']);
          }
        } catch (FormatException) {
          print("Received non-UTF8 data or malformed message: $data");
        } catch (e) {
          print("Error decoding message: $e");
        }
      }, onError: (error) {
        print("Error: $error");
        closeConnection();
      }, onDone: () {
        print("Server closed connection");
        closeConnection();
      });
    }
  }

  // Handle commands from the server (like online/offline notifications)
  void handleCommand(String command) {
    if (command.contains("online")) {
      chatController.text += "\n[User is online]";
    } else if (command.contains("offline")) {
      chatController.text += "\n[User is offline]";
    }
  }

  // Close the socket connection
  void closeConnection() {
    socketSubscription?.cancel();
    socket?.destroy();
    print("Connection closed");
  }
}