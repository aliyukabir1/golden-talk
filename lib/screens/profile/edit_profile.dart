import 'package:chat_app/core/shared_widgets/custom_button.dart';
import 'package:chat_app/core/shared_widgets/custom_textfield.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/profille_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  final UserModel user;
  EditProfileScreen({Key? key, required this.user}) : super(key: key);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    nameController.text = user.name;
    phoneController.text = user.phoneNumber;
    aboutMeController.text = user.aboutMe;
    getImage() async {
      ImagePicker imagePicker = ImagePicker();
      XFile? pickedImage =
          await imagePicker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        final imageFile = File(pickedImage.path);
        profileProvider.updateProfilePicture(imageFile);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Form(
          key: formKey,
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 70,
                      child: context.watch<ProfileProvider>().isImageLoading
                          ? const CircularProgressIndicator()
                          : CircleAvatar(
                              backgroundColor: Colors.red,
                              backgroundImage: NetworkImage(user.photoUrl),
                              radius: 68,
                            ),
                    ),
                    Positioned(
                        right: 10,
                        bottom: 5,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: IconButton(
                              onPressed: () {
                                getImage();
                              },
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.red,
                                size: 27,
                              )),
                        ))
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Your Information',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: nameController,
                hintText: 'Full Name',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: phoneController,
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                controller: aboutMeController,
                hintText: 'about me',
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              context.watch<ProfileProvider>().isLoading
                  ? const CircularProgressIndicator()
                  : CustomButton(
                      name: 'Save',
                      onTap: () {
                        try {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final newUser = user.copyWith(
                              name: nameController.text,
                              phoneNumber: phoneController.text,
                              aboutMe: aboutMeController.text);
                          if (user != newUser) {
                            profileProvider
                                .updateProfileInfo(newUser)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          } else {
                            Fluttertoast.showToast(msg: 'no changes made');
                          }
                        } catch (e) {
                          Fluttertoast.showToast(msg: e.toString());
                        }
                      },
                    )
            ],
          ),
        )),
      ),
    );
  }
}
