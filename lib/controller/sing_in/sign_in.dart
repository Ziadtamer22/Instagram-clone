import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_shop_new/view/home_page.dart';

class SignIController extends GetxController {
  late GlobalKey<FormState> formKey;
  String? email;
  String? password;
  String? name;

  @override
  void onInit() {
    super.onInit();
    formKey = GlobalKey<FormState>();
    check();
  }

  final auth = FirebaseAuth.instance;

  submit() async {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();

    try {
      final user = await auth.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );

      Get.snackbar('Welcome', '${user.user?.email}');

      Get.to(const HomePage());
    } on FirebaseAuthException catch (err) {
      Get.snackbar('Error', '${err.message}');
    } catch (err) {
      log(err.toString());
    }
  }

  check() async {
    await auth.currentUser?.reload();
    if (auth.currentUser == null) {
      log('no auth');
    } else {
      log(auth.currentUser!.email!);
    }
  }

  logout() async {
    await auth.signOut();
  }
}
