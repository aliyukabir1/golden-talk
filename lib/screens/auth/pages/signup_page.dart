import 'package:chat_app/core/shared_widgets/custom_button.dart';
import 'package:chat_app/core/shared_widgets/custom_textfield.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key? key}) : super(key: key);
  final _signUpFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController? _nameController = TextEditingController();
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Form(
        key: _signUpFormKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Welcome to Aliyos Chat',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                const Center(
                  child: Text(
                    'Register',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(controller: _nameController, hintText: 'Name'),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "email can not be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password field can not be empty";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                CustomButton(
                  name: 'Sign Up',
                  onTap: () async {
                    if (_signUpFormKey.currentState!.validate()) {
                      await authProvider.signUp(
                          email: _emailController.text,
                          password: _emailController.text,
                          name: _nameController.text);
                    }
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('if you already have an account '),
                    TextButton(
                        onPressed: () async {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                        },
                        child: const Text(
                          'click here',
                          style: TextStyle(color: Colors.orange),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
