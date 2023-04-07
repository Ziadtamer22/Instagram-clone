import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:work_shop_new/model/post_model.dart';

class PostController extends GetxController {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  RxBool isLoading = false.obs;
  Future<int> uploadPost(
      {required String imageUrl, required String description}) async {
    isLoading.value = true;
    String postId = const Uuid().v1();
    PostModel postModel = PostModel(
        imageUrl: imageUrl,
        description: description,
        dateTime: DateTime.now(),
        postId: postId);

    try {
      await firebaseFirestore
          .collection('posts')
          .doc(postId)
          .set(postModel.toFireStore())
          .whenComplete(() => isLoading.value = false);

      return 0;
    } catch (e) {
      log(e.toString());
      return 1;
    }
  }
}
