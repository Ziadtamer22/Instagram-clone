import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_shop_new/view/home_page.dart';

import '../controller/sing_up/sign_up.dart';

class SignUp extends GetView<SignUpController> {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignUpController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: controller.formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => controller.seleteImage(ImageSource.camera),
                    child: GetBuilder<SignUpController>(
                      builder: (controller) => Container(
                        height: 100,
                        width: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.grey),
                        child: controller.seletedImage != null
                            ? Image.file(
                                controller.seletedImage!,
                                fit: BoxFit.cover,
                              )
                            : const Icon(Icons.image),
                      ),
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Your Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Filed is required';
                      }
                    },
                    onSaved: (newValue) {
                      controller.name = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Email'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Filed is required';
                      }

                      if (!value.isEmail) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      controller.email = newValue;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This Filed is required';
                      }

                      if (value.length < 6) {
                        return 'Please enter at least 6 chars';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      controller.password = newValue;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      controller.submit(context);
                    },
                    child: const Text('Submit'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
