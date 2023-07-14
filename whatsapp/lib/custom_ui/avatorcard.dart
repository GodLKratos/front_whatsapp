import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whatsapp/Models/chatmodel.dart';

class AvatorCard extends StatelessWidget {
  final ChatModel chatmodel;
  const AvatorCard({super.key,required this.chatmodel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 23,
                backgroundColor: Colors.blueGrey,
                child:SvgPicture.asset(chatmodel.icon,color: Colors.white,height: 30,width: 30,)
              ),
              const Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 10,
                  child: Icon(Icons.clear,size: 13,color: Colors.white,),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2,),
           Text(chatmodel.name,style: TextStyle(fontSize: 12),),
        ],
      ),
    );
  }
}