import 'package:flutter/material.dart';
import 'package:whatsapp/Models/chatmodel.dart';
import 'package:whatsapp/Screens/HomeScreen.dart';
import 'package:whatsapp/custom_ui/buttoncard.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ChatModel? sourcechat;
  List<ChatModel> chats = [
    ChatModel(
      name: "Sachin saini",
      icon: "person.svg",
      isGroup: false,
      time: "10:20",
      currentMsg: "hii",
      status: "",
      select: false,
      id: 1,
    ),
    ChatModel(
        name: "Arjun Saini",
        icon: "person.svg",
        isGroup: true,
        time: "4:10",
        currentMsg: "hello ji",
        status: "",
        select: false,
        id: 2),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              sourcechat=chats.removeAt(index);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen(chat: chats,source: sourcechat!,)));
            },
            child: ButtonCard(name: chats[index].name, icon: chats[index].icon));
        },
      ),
    );
  }
}
