import 'package:chat_app/core/shared_widgets/custom_button.dart';
import 'package:chat_app/core/shared_widgets/custom_textfield.dart';
import 'package:chat_app/providers/auth_provider.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _signUpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController? nameController = TextEditingController();
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
                    'Register',
                    style: TextStyle(
                        color: Colors.orange,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                CustomTextField(controller: nameController, hintText: 'Name'),
                const SizedBox(height: 25),
                CustomTextField(
                  controller: emailController,
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
                  controller: passwordController,
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
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_signUpFormKey.currentState!.validate()) {
                      try {
                        await authProvider.signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            name: nameController.text);
                        if (!mounted) return;
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      } on FirebaseAuthException catch (e) {
                        Fluttertoast.showToast(msg: e.message!);
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
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
