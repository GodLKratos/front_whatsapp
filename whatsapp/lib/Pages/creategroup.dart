// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:whatsapp/Models/chatmodel.dart';
import 'package:whatsapp/custom_ui/avatorcard.dart';
import 'package:whatsapp/custom_ui/contactcard.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  List<ChatModel> contacts= [
    ChatModel(
        name: "Sachin saini",
        icon: "person.svg",
        isGroup: false,
        time: "10:20",
        currentMsg: "hii",
        status: "Hi i am flutter developer",
        select: false),
    ChatModel(
        name: "Arjun Saini",
        icon: "group.svg",
        isGroup: true,
        time: "4:10",
        currentMsg: "hello ji",
        status: "Hi i am React developer",
        select: false),
  ];
  List<ChatModel> groupmember = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff128c7e),
          title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "New Group",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Add participants",
                style: TextStyle(
                  fontSize: 13,
                ),
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
          ],
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: const Color(0xFF128C7E),
            onPressed: () {},
            child: const Icon(Icons.arrow_forward)),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: contacts.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Container(
                      height: groupmember.length > 0 ? 90 : 10,
                    );
                  }
                  return InkWell(
                    onTap: () {
                      setState(() {
                        if (contacts[index - 1].select == true) {
                          groupmember.remove(contacts[index - 1]);
                          contacts[index - 1].select = false;
                        } else {
                          groupmember.add(contacts[index - 1]);
                          contacts[index - 1].select = true;
                        }
                      });
                    },
                    child: ContactCard(
                      chatmodel: contacts[index - 1],
                    ),
                  );
                }),
            groupmember.length > 0
                ? Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Container(
                          height: 75,
                          color: Colors.white,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: contacts.length,
                              itemBuilder: (context, index) {
                                if (contacts[index].select == true) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        groupmember.remove(contacts[index]);
                                        contacts[index].select = false;
                                      });
                                    },
                                    child: AvatorCard(
                                      chatmodel: contacts[index],
                                    ),
                                  );
                                }
                                return Container();
                              }),
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ));
  }
}