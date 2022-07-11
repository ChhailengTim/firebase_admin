import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

imagePick(ImageSource source) async {
  final ImagePicker imagePicker = ImagePicker();

  XFile? file = await imagePicker.pickImage(source: source);

  if (file != null) {
    return await file.readAsBytes();
  }
  debugPrint("No image selected");
}
