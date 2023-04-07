import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:work_shop_new/view/upload_post.dart';
import 'package:work_shop_new/view/view_posts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  int pages = 0;
  void onTap(int page) {
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      pages = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white30,
        fixedColor: Colors.blue,
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Show Posts'),
          BottomNavigationBarItem(icon: Icon(Icons.upload), label: 'Upload')
        ],
        onTap: onTap,
        currentIndex: pages,
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: const [ViewPosts(), UploadPost()],
      ),
    );
  }
}
