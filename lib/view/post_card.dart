import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:work_shop_new/controller/sing_in/sign_in.dart';
import 'package:work_shop_new/controller/sing_up/sign_up.dart';

class PostCard extends StatelessWidget {
  PostCard({required this.postData});
  Map<String, dynamic> postData;
  SignUpController controller = SignUpController();
  bool isMessage = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.grey),
                  child: Image.network(myImage),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text('Ziad Tamer'),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Image.network(postData['imageurl']),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const LikeButton(
                  circleColor:
                      CircleColor(start: Colors.white, end: Colors.red),
                ),
                IconButton(
                    onPressed: (() {}),
                    icon: const Icon(Icons.message_rounded)),
                const SizedBox(
                  width: 50,
                ),
                Text(postData['desciption'])
              ],
            ),
          ],
        ),
      ),
    );
  }

//   message({required bool isMessage}) {
//     if (isMessage) {
//       return Get.defaultDialog(
//           title: 'Comment',
//           titleStyle: const TextStyle(fontSize: 20),
//           actions: [Text(postData['comment'])]);
//     }
//     return Get.defaultDialog(
//         title: 'Comment',
//         titleStyle: const TextStyle(fontSize: 20),
//         actions: [TextFormField()]);
}

const myImage =
    'https://firebasestorage.googleapis.com/v0/b/instgram-7eb32.appspot.com/o/files%2Fimage.jpg?alt=media&token=1c596e04-39f4-411b-96f2-064a08b3b44a';
