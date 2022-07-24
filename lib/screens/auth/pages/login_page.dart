import 'package:chat_app/core/shared_widgets/custom_button.dart';
import 'package:chat_app/core/shared_widgets/custom_textfield.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                  controller: emailController,
                  hintText: 'Email',
                  validator: (value) {
                    return si.validator.emailValidator(value);
                  },
                ),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: passwordController,
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
                      try {
                        await authProvider.login(
                            email: emailController.text,
                            password: passwordController.text);
                        if (!mounted) return;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomeScreen()));
                      } on FirebaseAuthException catch (e) {
                        Fluttertoast.showToast(msg: e.message!);
                      } catch (e) {
                        Fluttertoast.showToast(
                            msg: 'check internet connection and try again');
                      }
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
                                  builder: (context) => const SignUpPage()));
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
