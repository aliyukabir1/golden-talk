import "package:flutter/material.dart";

class LeftTextDisplay extends StatelessWidget {
  const LeftTextDisplay({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CircleAvatar(backgroundColor: Colors.red),
        const SizedBox(width: 10),
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width * 0.55,
          decoration: const BoxDecoration(
              color: Color.fromARGB(255, 4, 77, 7),
              borderRadius: BorderRadiusDirectional.only(
                  topEnd: Radius.circular(15),
                  bottomEnd: Radius.circular(15),
                  topStart: Radius.circular(15))),
          child: const Text(
            'What are you doing ? i have been trynna reach you no luck',
            style: TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
