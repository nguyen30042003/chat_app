import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../domains/usecase/group/get_connection.dart';
import '../service_locator.dart';

class SocketClient{
  late Socket socket;
  StreamSubscription? socketSubscription;



  Future<void> connect(int idGroup) async {
    final connection = await sl<GetConnection>().call(params: 4);
    socket = await Socket.connect(connection.IPv4, connection.port!);
    print("Connected to the server");

    var initObj = {
      'creationDateTime': DateTime.now().toIso8601String(),
      "userName": 'user2',
      "message": "ddd"
    };
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



  void listenForMessages() {
    socketSubscription = socket.listen((data) {
      try {
        String message = utf8.decode(data);
        print("Decoded message: $message");
        // Handle message processing here
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


  // void handleCommand(String command) {
  //   if (command.contains("online")) {
  //     chatController.text += "\n[User is online]";
  //   } else if (command.contains("offline")) {
  //     chatController.text += "\n[User is offline]";
  //   }
  // }

  // Close the socket connection
  void closeConnection() {
    socketSubscription?.cancel();
    socket?.destroy();
    print("Connection closed");
  }

}