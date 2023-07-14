class ChatModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMsg;
  String status;
  bool select = false;
  int? id;

  ChatModel(
      {required this.name,
      required this.icon,
      required this.isGroup,
      required this.time,
      required this.currentMsg,
      required this.status,
      required this.select,
      this.id
      });
}
