import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonCard extends StatelessWidget {
  final String name;
  final String icon;
  const ButtonCard({super.key, required this.name, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          radius: 23,
          backgroundColor: const Color(0xff25d366),
          child: SvgPicture.asset(
            icon,
            color: Colors.white,
            height: 30,
            width: 30,
          )),
      title: Text(
        name,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }
}
