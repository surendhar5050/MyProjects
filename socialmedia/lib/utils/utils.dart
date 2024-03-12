import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<Uint8List? > pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();

  XFile? file = await _imagePicker.pickImage(source: source);

  if (file != null) {
    Uint8List? bytes = await file.readAsBytes();
    return bytes;
  }

  // Return null if no image was picked.
  return null;

}

showsnackbar(BuildContext context,String res){

ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res)));
}