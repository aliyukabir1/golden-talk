import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/home_provider.dart';
import 'package:chat_app/screens/auth/pages/login_page.dart';
import 'package:chat_app/screens/chat_message/chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomeProvider>();
    final authProvider = context.read<AuthProvider>();
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Golden Chat'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (con) => const PopUp()));
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: homeProvider.getUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                final data = snapshot.data!.docs;
                return SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        data[index];
                        final user = UserModel.fromDocument(data[index]);
                        if (user.uid != authProvider.getCurrentUserId()) {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                            otherUserAvatar: user.photoUrl,
                                            otherUserId: user.uid,
                                            otherUserName: user.name == ''
                                                ? auth.currentUser!.email
                                                    as String
                                                : user.name,
                                          )));
                            },
                            leading: const CircleAvatar(
                                backgroundColor: Colors.purple),
                            title: Text(user.name == ''
                                ? auth.currentUser!.email as String
                                : user.name),
                            subtitle: const Text('we Got to talk'),
                            trailing: const Text('yesterday'),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      separatorBuilder: (_, index) => const Divider(
                            height: 1,
                          ),
                      itemCount: data.length),
                ));
              } else {
                return const Center(
                  child: Text('No Users'),
                );
              }
            }
            return const Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class PopUp extends StatelessWidget {
  const PopUp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Log Out'),
      content: const Text('Are you sure you want to log out?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('CANCEL'),
        ),
        TextButton(
          onPressed: () {
            context.read<AuthProvider>().signOut().then((value) =>
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen())));
          },
          child: const Text('ACCEPT'),
        ),
      ],
    );
  }
}
