import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:work_shop_new/controller/binding/post_binding.dart';

import 'package:work_shop_new/view/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:work_shop_new/view/sing_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(name: '/', page: () => const SignIn()),
        GetPage(
            name: '/HomePage',
            page: () => const HomePage(),
            binding: PostBinding()),
      ],
      initialRoute: '/',
    );
  }
}
