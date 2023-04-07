import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_shop_new/view/sing_in.dart';
import 'package:work_shop_new/view/sing_up.dart';

class SignUpController extends GetxController {
  late GlobalKey<FormState> formKey;
  String? name;
  String? phone;
  String? email;
  String? password;
  String? imgUrl;

  File? seletedImage;

  late ImagePicker _picker;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    _picker = ImagePicker();
  }

  final auth = FirebaseAuth.instance;

  final userCollection = FirebaseFirestore.instance.collection('users');

  submit(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      userCollection.doc(credential.user?.uid).set(
        {
          'name': name,
          'email': email,
          if (imgUrl != null) 'profilePicture': imgUrl,
        },
      );

      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          Get.snackbar('Welcome ', '${credential.user?.email}');
        },
      );
      Get.to(const SignIn());
    } on FirebaseAuthException catch (e) {
      WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) {
          Get.snackbar('Error : ', '${e.message}');
        },
      );
    }
  }

  var serverPath = 'files/image.jpg';
  final fileStorage = FirebaseStorage.instance.ref();

  seleteImage(ImageSource source) async {
    final image = await _picker.pickImage(source: source);
    if (image == null) return;
    log(image.path.toString());
    seletedImage = File(image.path);
    update();
    if (seletedImage != null) {
      uploadOnServer();
    }
    // try {
    //   final ref = fileStorage.child(serverPath);
    //   final uploadImage = ref.putFile(seletedImage!);
    //   final snapShot = await uploadImage.whenComplete(() {});
    //   imgUrl = await snapShot.ref.getDownloadURL();
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  uploadOnServer() async {
    try {
      final ref = fileStorage.child(serverPath);
      final uploadImage = ref.putFile(seletedImage!);
      final snapShot = await uploadImage.whenComplete(() {});
      imgUrl = await snapShot.ref.getDownloadURL();
    } catch (e) {
      log(e.toString());
    }
  }
}
 

      // final response = await userCollection.add(
      //   {
      //     'name': name,
      //     'email': email,
      //     'phone': phone,
      //   },
      // );

      // log(response.toString());

      // final data = await userCollection.doc(credential.user?.uid).get();
      // log(data.data().toString());

      // await userCollection.doc(credential.user?.uid).delete()