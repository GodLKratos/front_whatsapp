import 'package:flutter/material.dart';

class OwnMsg extends StatelessWidget {
  final  String? msg;
  const OwnMsg({super.key, this.msg});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width - 45),
        child:  Card(
          margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
          color: const Color(0xffdcf8c6),
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
            child: Row(
              children: [
                Text("20:1",style: TextStyle(fontSize: 13,color: Color.fromARGB(255, 93, 92, 92)),),
                SizedBox(
                  width: 5,
                ),
                Icon(Icons.done_all,size: 20,),
              ],
            ),
          )
        ])),
      ),
    );
  }
}
