import 'package:chat_app/core/shared_widgets/custom_button.dart';
import 'package:chat_app/core/shared_widgets/custom_textfield.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/injector.dart';
import 'signup_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _loginFormKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
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
                    'Log In',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  validator: (value) {
                    return si.validator.emailValidator(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: _passwordController,
                  hintText: "Password",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password can not be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                CustomButton(
                  name: 'Log In',
                  onTap: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_loginFormKey.currentState!.validate()) {
                      await authProvider.login(context,
                          email: _emailController.text,
                          password: _passwordController.text);
                    }
                  },
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('if you dont have an account already,'),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpPage()));
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
