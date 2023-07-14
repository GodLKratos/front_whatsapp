import 'package:flutter/material.dart';

class ReplyMsg extends StatelessWidget {
  final  String? msg;
  const ReplyMsg({super.key, this.msg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child:  Card(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child:  Stack(children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 60,top: 5,bottom: 20),
            child: Text("$msg",style: const TextStyle(fontSize: 16),),
          ),
          const Positioned(
            bottom: 4,
            right: 10,
            child: 
                Text("20:1",style: TextStyle(fontSize: 13,color: Color.fromARGB(255, 93, 92, 92)),),
          )
        ])),
      ),
    );
  }
}
