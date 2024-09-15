import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:chat_project/models/message.dart';
import 'package:chat_project/screens/bloc/get_message_cubit.dart';
import 'package:chat_project/screens/widget/message_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../configuation/app_vectors_and_images.dart';
import '../domains/usecase/group/get_connection.dart';
import '../service_locator.dart';
import 'bloc/get_message_state.dart';
import 'homepage.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key, required this.idGroup, required this.userId, required this.userName});
  final int idGroup;
  final int userId;
  final String userName;



  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controllerMessage = TextEditingController();
  List<Message> _messages = [];
  late Socket socket;
  StreamSubscription? socketSubscription;
  late String userNameOwner;
  @override
  void initState() {
    super.initState();
    connect();
    getAccount();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetMessageCubit(widget.idGroup)..getMessage(),
      child: Scaffold(
        backgroundColor: const Color(0xff1B202D),
        body: Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: SafeArea(
            child: Column(
              children: [
                appbar(widget.userName, context),
                const SizedBox(height: 20),
                Expanded(
                  child: BlocBuilder<GetMessageCubit, GetMessageState>(
                    builder: (context, state) {
                      if (state is GetMessageLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (state is GetMessageLoaded) {
                        final allMessages = [..._messages,...state.pageMessage.content!];
                        if (allMessages.isNotEmpty) {
                          return ListView.builder(
                            reverse: true,
                            itemCount: allMessages.length,
                            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .01),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return MessageCard(
                                message: allMessages[index],
                                username: userNameOwner,
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text('Say Hii! 👋', style: TextStyle(fontSize: 20)));
                        }
                      }
                      if (state is GetMessageFailure) {
                        return const Center(child: Text('Error loading message'));
                      }
                      return Container();
                    },
                  ),
                ),
                buildMessageInput(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMessageInput(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 13,
      decoration: const BoxDecoration(
        color: Color(0xff1B202D),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Color(0xff1B202D),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, -1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: const Color(0xff2A2D38),
              ),
              child: TextField(
                controller: _controllerMessage,
                decoration: const InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(color: Colors.white54),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              String messageText = _controllerMessage.text.trim();
              if (messageText.isNotEmpty) {
                GroupChat group = GroupChat(id: 1, groupName: "sdsd", timeCreate: DateTime.now().toIso8601String());
                Message message = Message(
                  id: DateTime.now().millisecondsSinceEpoch,
                  creationDateTime: DateTime.now().toIso8601String(),
                  userName: userNameOwner,
                  message: messageText,
                  groupChat: group,
                );
                var initObj = {
                  'creationDateTime': DateTime.now().toIso8601String(),
                  "userName": userNameOwner,
                  "message": messageText
                };
                sendObject(initObj);

                setState(() {
                  _messages.insert(0, message); // Thêm tin nhắn mới vào danh sách
                });

                _controllerMessage.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: const Text('Send', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }


  void getAccount() async{
    final prefs = await SharedPreferences.getInstance();
    userNameOwner = prefs.getString('username') ?? "";
  }

  void connect() async {
    final connection = await sl<GetConnection>().call(params: 4);
    socket = await Socket.connect(connection.IPv4, connection.port!);
    print("Connected to the server");

    // Initialize with the server (send InitObj)
    var initObj = {
      'creationDateTime': DateTime.now().toIso8601String(),
      "userName": userNameOwner,
      "message": "ddd"
    };
    sendObject(initObj);
    listenForMessages();
  }


  void sendMessage(String messageToSend) {
    if (socket != null && socket!.remoteAddress != null) {
      var messageObj = {
        'timestamp': DateTime.now().toIso8601String(),
        "username": userNameOwner,
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
          String message = utf8.decode(data);
          var decodedMessage = jsonDecode(message);
          if (decodedMessage['message'] != null) {
            GroupChat group = GroupChat(id: 1, groupName: "sdsd", timeCreate: DateTime.now().toIso8601String());
            Message message = Message(
              id: DateTime.now().millisecondsSinceEpoch,
              creationDateTime: DateTime.now().toIso8601String(),
              userName: decodedMessage['username'],
              message: decodedMessage['message'],
              groupChat: group,
            );

            setState(() {
              _messages.insert(0, message);
            });
          } else if (decodedMessage['command'] != null) {
            handleCommand(decodedMessage['command']);
          }
        } on FormatException {
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
      // chatController.text += "\n[User is online]";
    } else if (command.contains("offline")) {
      // chatController.text += "\n[User is offline]";
    }
  }

  // Close the socket connection
  void closeConnection() {
    socketSubscription?.cancel();
    socket?.destroy();
    print("Connection closed");
  }
}

Widget appbar(String name, BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height / 16,
    decoration: const BoxDecoration(
      color: Color(0xff1B202D),
    ),
    child: Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Homepage()));
          },
        ),
        const SizedBox(width: 10),
        CircleAvatar(
          radius: 20,
          backgroundImage: Image.asset(
            AppVectorsAndImages.getLinkImage("user1"),
          ).image,
        ),
        const SizedBox(width: 10),
        Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Quicksand',
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}