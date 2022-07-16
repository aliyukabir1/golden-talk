import 'package:flutter/material.dart';

class RightTextDisPlay extends StatelessWidget {
  const RightTextDisPlay({Key? key}) : super(key: key);

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
          child: const Text(
            'I was really busy, i will catch up to you later...',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 10),
        const CircleAvatar(backgroundColor: Colors.red),
      ],
    );
  }
}
