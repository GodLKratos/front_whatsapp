import 'package:flutter/material.dart';
import 'package:whatsapp/Models/chatmodel.dart';
import 'package:whatsapp/Pages/creategroup.dart';
import 'package:whatsapp/custom_ui/buttoncard.dart';
import 'package:whatsapp/custom_ui/contactcard.dart';

class SelectContact extends StatefulWidget {
  const SelectContact({super.key});

  @override
  State<SelectContact> createState() => _SelectContactState();
}

class _SelectContactState extends State<SelectContact> {
  List<ChatModel> lst = [
    ChatModel(
        name: "Sachin saini",
        icon: "person.svg",
        isGroup: false,
        time: "10:20",
        currentMsg: "hii",
        status: "Hi i am flutter developer",
        select: false
        ),
    ChatModel(
        name: "Arjun Saini",
        icon: "group.svg",
        isGroup: true,
        time: "4:10",
        currentMsg: "hello ji",
        status: "Hi i am React developer",
        select: false),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff128c7e),
        title: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Contacts',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
            Text(
              '255 contact',
              style: TextStyle(fontSize: 13),
            )
          ],
        ),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.search,
                size: 26,
              ),
              onPressed: () {}),
          PopupMenuButton<String>(
              onSelected: (value) {},
              itemBuilder: ((context) {
                return [
                  const PopupMenuItem(value: "Invite a friend", child: Text('Invite a friend')),
                  const PopupMenuItem(
                      value: "Contacts", child: Text('Contacts')),
                  const PopupMenuItem(
                      value: "Refresh", child: Text('Refresh')),
                  const PopupMenuItem(
                      value: "Help",
                      child: Text('Help')),
                ];
              }))
        ],
      ),
      body:ListView.builder(
        itemCount: lst.length+2,
        itemBuilder: (BuildContext context, int index) {
          {
            if(index == 0){
              return  InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateGroup()));
                },
                child: const ButtonCard(name: "New Group", icon:"group.svg" ));
            }
            else if(index == 1){
              return const ButtonCard(name: "New Contact", icon: "person.svg");
            }
            return ContactCard(chatmodel: lst[index-2]);
          }
        },
      ),
    );
  }
}
