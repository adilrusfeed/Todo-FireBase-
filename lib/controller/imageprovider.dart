import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagesProvider extends ChangeNotifier {
  File? selectImage;
  ImagePicker imagepicker = ImagePicker();
  void setImage(ImageSource source) async {
    final pickedImage = await imagepicker.pickImage(source: source);
    selectImage = pickedImage != null ? File(pickedImage.path) : null;
    notifyListeners();
  }
}
