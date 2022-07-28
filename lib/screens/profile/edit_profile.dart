import 'package:chat_app/core/shared_widgets/custom_button.dart';
import 'package:chat_app/core/shared_widgets/custom_textfield.dart';
import 'package:chat_app/models/user.dart';
import 'package:chat_app/providers/profille_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class EditProfileScreen extends StatelessWidget {
  final UserModel user;
  const EditProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = context.read<ProfileProvider>();

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
          child: Column(
            children: [
              const SizedBox(height: 30),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 70,
                      child: CircleAvatar(
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
                initialValue: user.name,
                hintText: 'Full Name',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                initialValue: user.phoneNumber,
                hintText: 'Phone Number',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                initialValue: user.aboutMe,
                hintText: 'about me',
                keyboardType: TextInputType.multiline,
                maxLines: 5,
              ),
              const SizedBox(height: 20),
              CustomButton(
                name: 'Save',
                onTap: () {},
              )
            ],
          ),
        )),
      ),
    );
  }
}
