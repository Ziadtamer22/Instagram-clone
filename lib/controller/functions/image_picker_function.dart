import 'dart:developer';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  ImagePicker imagePicker = ImagePicker();
  XFile? image = await imagePicker.pickImage(source: source);
  if (image != null) {
    return await image.readAsBytes();
  }
  log('Error image');
}
