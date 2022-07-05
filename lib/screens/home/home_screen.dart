import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/screens/auth/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: const [
            ListTile(
              leading: CircleAvatar(backgroundColor: Colors.purple),
              title: Text('Aliyos Himself'),
              subtitle: Text('we Got to talk'),
              trailing: Text('yesterday'),
            ),
            ListTile(
              leading: CircleAvatar(backgroundColor: Colors.purple),
              title: Text('Aliyos Himself'),
              subtitle: Text('we Got to talk'),
              trailing: Text('yesterday'),
            ),
          ],
        ),
      )),
    );
  }
}
