import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MyImageProvider extends ChangeNotifier {
  File? _imagefile;

  File? getCNICFile() {
    return _imagefile;
  }

  Future<void> getImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      // Pick an image
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      //File(image).readAsBytes().asStream();
      //TO convert Xfile into file
      _imagefile = File(image!.path);
      print('Image picked');
    } catch (e) {
      print('No File Picked');
    }
    //file!.readAsBytes().asStream();
    //print('Image picked');

    notifyListeners();
  }
}
