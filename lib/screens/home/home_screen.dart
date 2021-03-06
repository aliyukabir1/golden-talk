import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/home_provider.dart';
import 'package:chat_app/screens/auth/pages/login_page.dart';
import 'package:chat_app/screens/chat_message/chat_screen.dart';
import 'package:chat_app/screens/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomeProvider>();
    final authProvider = context.read<AuthProvider>();

    chooseAvatar(String url) {
      if (url != '') {
        return CircleAvatar(
            backgroundImage: NetworkImage(url), backgroundColor: Colors.purple);
      } else {
        return const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
            backgroundColor: Colors.purple);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Golden Chat'),
        centerTitle: true,
        leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const ProfileScreen())));
            }),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => const PopUp())));
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
                                                ? user.email
                                                : user.name,
                                          )));
                            },
                            leading: chooseAvatar(user.photoUrl),
                            title:
                                Text(user.name == "" ? user.email : user.name),
                            subtitle: Text(user.aboutMe),
                            // trailing: const Text('yesterday'),
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
    return Scaffold(
      body: AlertDialog(
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
      ),
    );
  }
}
