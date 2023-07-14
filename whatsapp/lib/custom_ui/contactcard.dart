import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/Models/chatmodel.dart';

class ContactCard extends StatelessWidget {
  final ChatModel chatmodel;
  const ContactCard({super.key,required this.chatmodel});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 53,
        width: 50,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 23,
              backgroundColor: Colors.blueGrey,
              child:SvgPicture.asset(chatmodel.icon,color: Colors.white,height: 30,width: 30,)
            ),
            chatmodel.select == true?
            const Positioned(
              bottom: 4,
              right: 5,
              child: CircleAvatar(
                backgroundColor: Colors.teal,
                radius: 10,
                child: Icon(Icons.check,size: 10,),
              ),
            ):Container(),
          ],
        ),
      ),
      title:  Text(chatmodel.name,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
      subtitle:  Text(chatmodel.status,style: const TextStyle(fontSize: 13),),
    );
  }
}