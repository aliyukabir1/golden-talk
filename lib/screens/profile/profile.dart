import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: FutureBuilder<DocumentSnapshot>(
          future: authProvider.getCurrentUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final user = UserModel.fromDocument(snapshot.data!);
              final instance = FirebaseAuth.instance.currentUser;
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    Stack(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .25,
                        ),
                        Container(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .2,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.blue, Colors.white],
                                  begin: Alignment.bottomRight,
                                  end: Alignment.topLeft)),
                        ),
                        const Positioned(
                          bottom: 0,
                          left: 10,
                          child: CircleAvatar(
                            backgroundColor: Colors.pink,
                            radius: 55,
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 53,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.name ?? instance!.email as String,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 10),
                    const Divider(
                      color: Color.fromARGB(255, 56, 53, 53),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          user.aboutMe ?? 'null',
                          style: const TextStyle(fontSize: 17),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
