import 'package:flutter/material.dart';
import 'package:whatsapp/Models/chatmodel.dart';
import 'package:whatsapp/Pages/Chatpage.dart';
import 'package:whatsapp/Pages/camerapage.dart';

class HomeScreen extends StatefulWidget {
  final List<ChatModel> chat;
  final ChatModel source;
  const HomeScreen({super.key,required this.chat,required this.source});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff128c7e),
        automaticallyImplyLeading: false,
        title: const Text("Whatsapp SS"),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            onSelected: (value){
              print(value);
            },
            itemBuilder: ((context) {
            return [
              const PopupMenuItem(value: "New group", child: Text('New group')),
              const PopupMenuItem(value: "New broadcast", child: Text('New broadcast')),
              const PopupMenuItem(value: "Whatsapp Web", child: Text('Whatsapp Web')),
              const PopupMenuItem(value: "Starred messages", child: Text('Starred messages')),
              const PopupMenuItem(value: "Settings", child: Text('Settings')),
            ];
          }))
        ],
        bottom: TabBar(controller: _controller,
        indicatorColor: Colors.white,
         tabs: const [
          Tab(icon: Icon(Icons.camera_alt_sharp)),
          Tab(
            text: "CHATS",
          ),
          Tab(
            text: "STATUS",
          ),
          Tab(
            text: "CALLS",
          )
        ]),
      ),
      body: TabBarView(
        controller: _controller,
        children:  [
          //CameraPage(),
          const Text("wf"),
          Chatpage(chat: widget.chat,source: widget.source,),
          const Text('Status'),
          const Text("Calls"),
        ],
      ),
    );
  }
}
