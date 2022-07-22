import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';

class RightTextDisPlay extends StatelessWidget {
  final Message message;

  const RightTextDisPlay({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.55,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 8, 58, 99),
                borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(15),
                    bottomStart: Radius.circular(15),
                    topStart: Radius.circular(15))),
            child: message.type == 0
                ? Text(
                    message.content,
                    style: const TextStyle(color: Colors.white),
                  )
                : Image.network(
                    message.content,
                    width: 150,
                  )),
        const SizedBox(width: 10),
        const CircleAvatar(backgroundColor: Colors.red),
      ],
    );
  }
}
