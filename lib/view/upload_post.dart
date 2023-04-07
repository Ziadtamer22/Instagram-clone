import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:work_shop_new/controller/functions/image_picker_function.dart';
import 'package:work_shop_new/controller/functions/storage_function.dart';
import 'package:work_shop_new/controller/postcontroller/post_controller.dart';

class UploadPost extends StatefulWidget {
  const UploadPost({super.key});

  @override
  State<UploadPost> createState() => _UploadPostState();
}

class _UploadPostState extends State<UploadPost> {
  Uint8List? imageFile;
  String? imageUrl;
  TextEditingController controller = TextEditingController();
  PostController postController = PostController();
  selectImage(BuildContext context) async {
    return Get.defaultDialog(title: 'Pick Image', middleText: '', actions: [
      ElevatedButton(
        onPressed: (() async {
          Uint8List flie = await pickImage(ImageSource.camera);
          setState(() {
            Get.back();
            imageFile = flie;
          });
        }),
        child: const Text('Pick From Camera'),
      ),
      ElevatedButton(
        onPressed: (() async {
          Uint8List flie = await pickImage(ImageSource.gallery);
          setState(() {
            Get.back();
            imageFile = flie;
          });
        }),
        child: const Text('Pick From Gallery'),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Screen')),
      body: imageFile == null
          ? Scaffold(
              body: Center(
                child: IconButton(
                  onPressed: () {
                    selectImage(context);
                  },
                  icon: const Icon(
                    Icons.upload,
                    size: 25,
                  ),
                ),
              ),
            )
          : Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Image(
                      image: MemoryImage(imageFile!, scale: 1),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                          hintText: 'description',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GetX(
                      init: PostController(),
                      builder: ((_) => postController.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              onPressed: () async {
                                imageUrl = await StorageMethod()
                                    .uploadImage(image: imageFile!);
                                postController
                                    .uploadPost(
                                        imageUrl: imageUrl!,
                                        description: controller.text)
                                    .whenComplete(() => clear());
                              },
                              child: const Text('upload'))),
                    )
                  ],
                ),
              ),
            ),
    );
  }

  clear() {
    setState(() {
      imageFile = null;
      controller.clear();
    });
  }
}
