import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp/Models/chatmodel.dart';
import 'package:whatsapp/Pages/individualpage.dart';


class CustomCard extends StatelessWidget {
  final ChatModel chatmodel;
  final ChatModel source;
  const CustomCard({super.key,required this.chatmodel,required this.source});
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> IndividualPage(chatModel:chatmodel,source: source,)));
      },
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueGrey,
          child: SvgPicture.asset(chatmodel.isGroup?"assets/group.svg":"assets/person.svg",color: Colors.white,width: 37,height: 37,),
        ),
        trailing:  Text(chatmodel.time),
        title:  Text(chatmodel.name,style: const TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
        subtitle:  Row(
          children: [
            const Icon(Icons.done_all),
            Text(chatmodel.currentMsg,style: const TextStyle(fontSize: 13),)
          ],
        ),
      ),
    );
  }
}