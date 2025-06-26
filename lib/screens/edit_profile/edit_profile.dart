import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:techify/constants/colors.dart';
import 'package:techify/constants/sized_box.dart';
import 'package:techify/models/user_model/user_model.dart';
import 'package:techify/provider/app_provider.dart';
import 'package:techify/widgets/buttons/primary_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController updateNameController = TextEditingController();
  File? image;

  @override
  void initState() {
    super.initState();
    final userModel =
        Provider.of<AppProvider>(context, listen: false).getUserInfo;
    updateNameController.text = userModel.name;
  }

  void takePicture() async {
    XFile? takenimage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 40,
    );
    if (takenimage != null) {
      setState(() {
        image = File(takenimage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    AppProvider appProvider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyColors.blackColor,
          ),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: const CircleAvatar(
                      radius: 50,
                      backgroundColor: MyColors.primaryColor,
                      child: Icon(
                        Icons.camera_alt,
                        color: MyColors.blackColor,
                      )),
                )
              : CupertinoButton(
                  onPressed: () {
                    takePicture();
                  },
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(image!),
                  ),
                ),
          10.height,
          TextFormField(
            controller: updateNameController,
            cursorColor: MyColors.primaryColor,
            decoration: InputDecoration(
              hintText: appProvider.getUserInfo.name,
              prefixIcon: const Icon(
                Icons.person_outline,
              ),
            ),
          ),
          30.height,
          SizedBox(
            width: 20,
            child: MyPrimaryButton(
              onPressed: () async {
                UserModel userModel = appProvider.getUserInfo
                    .copyWith(name: updateNameController.text);
                appProvider.updateUserInfoFirebase(context, userModel, image);
              },
              title: "Update",
            ),
          )
        ],
      ),
    );
  }
}
