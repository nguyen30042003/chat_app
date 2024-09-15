import 'dart:ui';

import 'package:chat_project/models/message.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key, required this.message, required this.username});

  final Message message;
  final String username;
  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {



  @override
  Widget build(BuildContext context) {
    return widget.username == widget.message.userName ?  _darkMessage() : _blueMessage() ;
  }

  Widget _blueMessage(){
    return Row(
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left:  MediaQuery.sizeOf(context).height*0.04),
                child: Text(widget.message.userName, style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white
                ),),
              ),
              Container(
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).height*0.04),
                margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.sizeOf(context).width*0.04, vertical: MediaQuery.sizeOf(context).height*0.01),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 221, 245, 255),
                  border: Border.all(color: Colors.lightBlue),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )
                ),
                child: Text(
                  widget.message.message,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(widget.message.creationDateTime,
          style: const TextStyle(
              fontSize: 13,
              color: Colors.white
          ),
        )
      ],
    );
  }
  Widget _darkMessage(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: MediaQuery.sizeOf(context).width*0.04),
          child: Text(widget.message.creationDateTime,
            style: const TextStyle(
                fontSize: 13,
                color: Colors.white
            ),
          ),
        ),
        Flexible(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(MediaQuery.sizeOf(context).height*0.04),
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.sizeOf(context).width*0.04, vertical: MediaQuery.sizeOf(context).height*0.01),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 42, 135, 168),
                    border: Border.all(color: Colors.lightBlue),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    )
                ),
                child: Text(
                  widget.message.message,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
