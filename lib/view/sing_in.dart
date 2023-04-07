import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:work_shop_new/view/sing_up.dart';

import '../controller/sing_in/sign_in.dart';

class SignIn extends GetView<SignIController> {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SignIController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                  // controller.logout();
                  controller.submit();
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Do you have account?',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(() => const SignUp());
                      },
                      child: const Text('Sign up'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
