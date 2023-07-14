import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/Models/chatmodel.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:whatsapp/Models/msgmodel.dart';
import 'package:whatsapp/custom_ui/ownmsg.dart';
import 'package:whatsapp/custom_ui/replymsg.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IndividualPage extends StatefulWidget {
  final ChatModel chatModel;
  final ChatModel source;
  const IndividualPage(
      {super.key, required this.chatModel, required this.source});

  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  bool _showEmoji = false;
  bool sendbutton = false;
  FocusNode focusnode = FocusNode();
  final TextEditingController _textcontroller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  List<MsgModel> msglist = [];
  IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    connectfn();
  }

  connectfn() {
    socket = IO.io("http://localhost:3000/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false
    });
    socket!.connect();
    socket!.emit("signin", widget.source.id);
    socket!.onConnect((data) {
      socket!.on('message', (msg) {
        setmsg("destination", msg["message"]);
      });
    });
  }

  void sendMsg(String msg, int sourceid, int targetid) {
    setmsg("source", msg);
    socket!.emit("message",
        {"message": msg, "sourceid": sourceid, "targetid": targetid});
  }

  void setmsg(String type, String message) {
    MsgModel msgmodel = MsgModel(type: type, message: message);
    setState(() {
      msglist.add(msgmodel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_showEmoji) {
          setState(() {
            _showEmoji = !_showEmoji;
          });
          return Future.value(false);
        } else {
          return Future.value(true);
        }
      },
      child: Stack(
        children: [
          Image.asset(
            "assets/back.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: const Color(0xff128c7e),
              leadingWidth: 100,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(
                      context); //to close the current screen and go back to previous page when
                },
                child: Row(children: [
                  const Icon(Icons.arrow_back),
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.blueGrey,
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup
                          ? "assets/group.svg"
                          : "assets/person.svg",
                      color: Colors.white,
                      width: 37,
                      height: 37,
                    ),
                  ),
                ]),
              ),
              title: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name,
                      style: const TextStyle(
                          fontSize: 18.5, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'last seen today at 12:05',
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
                PopupMenuButton<String>(
                    onSelected: (value) {},
                    itemBuilder: ((context) {
                      return [
                        const PopupMenuItem(
                            value: "Viwe contact", child: Text('Viwe contact')),
                        const PopupMenuItem(
                            value: "Media,link and docs",
                            child: Text('Media,link and docs')),
                        const PopupMenuItem(
                            value: "Whatsapp web", child: Text('Whatsapp web')),
                        const PopupMenuItem(
                            value: "Search", child: Text('Search')),
                        const PopupMenuItem(
                            value: "Mute Notification",
                            child: Text('Mute Notification')),
                        const PopupMenuItem(
                            value: "Wallpaper", child: Text('Wallpaper')),
                      ];
                    }))
              ],
            ),
            body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: Column(
                    children: [
                      Expanded(
                        //height: MediaQuery.of(context).size.height - 140,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: msglist.length+1,
                          itemBuilder: (BuildContext context, int index) {
                            if(index == msglist.length){
                              return Container(height: 70,);
                            }
                            if (msglist[index].type == "source") {
                              return OwnMsg(msg: msglist[index].message);
                            } else {
                              return ReplyMsg(msg: msglist[index].message);
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 55,
                                        height: MediaQuery.of(context).size.height*0.08,
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                        child: TextFormField(
                                            onChanged: (val) {
                                              if (val.isNotEmpty) {
                                                setState(() {
                                                  sendbutton = true;
                                                });
                                              } else {
                                                setState(() {
                                                  sendbutton = false;
                                                });
                                              }
                                            },
                                            controller: _textcontroller,
                                            focusNode: focusnode,
                                            onTap: () {
                                              setState(() {
                                                if (_showEmoji != false) {
                                                  _showEmoji = !_showEmoji;
                                                }
                                              });
                                            },
                                            keyboardType:
                                                TextInputType.multiline,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            maxLines: 5,
                                            minLines: 1,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Enter message",
                                                prefixIcon: IconButton(
                                                  onPressed: () {
                                                    focusnode.unfocus();
                                                    focusnode.canRequestFocus =
                                                        false;
                                                    setState(() {
                                                      _showEmoji = !_showEmoji;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                      Icons.emoji_emotions),
                                                ),
                                                suffixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          showModalBottomSheet(
                                                            backgroundColor:
                                                                Colors
                                                                    .transparent,
                                                            context: context,
                                                            builder: (builder) =>
                                                                bottomSheet(
                                                                    context),
                                                          );
                                                        },
                                                        icon: const Icon(
                                                            Icons.attach_file),
                                                      ),
                                                      IconButton(
                                                          onPressed: () {},
                                                          icon: const Icon(
                                                              Icons.camera_alt))
                                                    ],
                                                  ),
                                                ))),
                                      ),
                                    )),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: const Color(0xff128c7e),
                                    child: IconButton(
                                        onPressed: () {
                                          if (sendbutton) {
                                            _scrollController.animateTo(
                                                _scrollController
                                                    .position.maxScrollExtent,
                                                duration:
                                                    Duration(microseconds: 300),
                                                curve: Curves.easeOut);
                                            sendMsg(
                                                _textcontroller.text,
                                                widget.source.id!,
                                                widget.chatModel.id!);
                                            _textcontroller.clear();
                                          }
                                        },
                                        icon: Icon(
                                          sendbutton ? Icons.send : Icons.mic,
                                          color: Colors.white,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            // _showEmoji
                            //     ? SizedBox(
                            //         height:
                            //             MediaQuery.of(context).size.height * 0.03,
                            //         child: EmojiPicker(
                            //           textEditingController: _textcontroller,
                            //           config: const Config(
                            //             columns: 8,
                            //             emojiSizeMax: 32,
                            //           ),
                            //         ),
                            //       )
                            //     : Container(),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}

Widget bottomSheet(context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.4,
    width: MediaQuery.of(context).size.width,
    child: Card(
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                makeicons(Icons.insert_drive_file, Colors.indigo, "Document"),
                const SizedBox(
                  width: 40,
                ),
                makeicons(Icons.camera_alt, Colors.pink, "Camera"),
                const SizedBox(
                  width: 40,
                ),
                makeicons(Icons.insert_photo, Colors.purple, "Gallery"),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                makeicons(Icons.headset, Colors.orange, "Audio"),
                const SizedBox(
                  width: 40,
                ),
                makeicons(Icons.location_pin, Colors.teal, "Location"),
                const SizedBox(
                  width: 40,
                ),
                makeicons(Icons.person, Colors.blue, "Contact"),
              ],
            )
          ],
        ),
      ),
    ),
  );
}

Widget makeicons(IconData icon, Color color, String text) {
  return Column(
    children: [
      CircleAvatar(
        radius: 30,
        backgroundColor: color,
        child: Icon(icon),
      ),
      const SizedBox(
        height: 5,
      ),
      Text(
        text,
        style: const TextStyle(fontSize: 12),
      )
    ],
  );
}
