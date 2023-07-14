import 'package:flutter/material.dart';
import 'package:whatsapp/Models/chatmodel.dart';
import 'package:whatsapp/Pages/selectcontact.dart';
import 'package:whatsapp/custom_ui/custom_card.dart';

class Chatpage extends StatefulWidget {
  final List<ChatModel> chat;
  final ChatModel source;
  const Chatpage({super.key,required this.chat,required this.source});

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const SelectContact()));
        },
        child: const Icon(Icons.chat),
      ),
      body: ListView.builder(
        itemCount: widget.chat.length,
        itemBuilder: (BuildContext context, int index) {
          return CustomCard(chatmodel: widget.chat[index],source: widget.source,);
        },
      ),
    );
  }
}
