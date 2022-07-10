import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/providers/home_provider.dart';
import 'package:chat_app/screens/auth/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.read<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Golden Chat'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () async {
                await context.read<AuthProvider>().signOut();
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
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
                        final user = User.fromDocument(data[index]);
                        return ListTile(
                          leading: const CircleAvatar(
                              backgroundColor: Colors.purple),
                          title: Text(user.name),
                          subtitle: const Text('we Got to talk'),
                          trailing: const Text('yesterday'),
                        );
                      },
                      separatorBuilder: (_, index) => const Divider(
                            height: 1,
                          ),
                      itemCount: data.length),
                  // child: Column(
                  //   children: const [
                  //     ListTile(
                  //       leading: CircleAvatar(backgroundColor: Colors.purple),
                  //       title: Text('Aliyos Himself'),
                  //       subtitle: Text('we Got to talk'),
                  //       trailing: Text('yesterday'),
                  //     ),
                  //     ListTile(
                  //       leading: CircleAvatar(backgroundColor: Colors.purple),
                  //       title: Text('Aliyos Himself'),
                  //       subtitle: Text('we Got to talk'),
                  //       trailing: Text('yesterday'),
                  //     ),
                  //   ],
                  // ),
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
