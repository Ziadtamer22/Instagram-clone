import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageMethod {
  FirebaseStorage storage = FirebaseStorage.instance;
  Future<String> uploadImage({
    required Uint8List image,
  }) async {
    try {
      String id = const Uuid().v1();
      Reference ref = storage.ref().child('postsImage').child(id);
      UploadTask uploadTask = ref.putData(image);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      log(e.toString());
      return 'Error';
    }
  }
}
