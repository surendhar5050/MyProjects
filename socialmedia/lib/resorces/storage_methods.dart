import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
// import 'package:flutter/material.dart';

class Storagemethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uplaodimageStorage(
      String childName, Uint8List file, bool ispost) async {
    Reference _ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (ispost) {
      String id = const Uuid().v1();
      _ref = _ref.child(id);
    }
    UploadTask _task = _ref.putData(file);

    TaskSnapshot _taskSnapSnot = await _task;

    String downLoadurl = await _taskSnapSnot.ref.getDownloadURL();

    return downLoadurl;
  }
}
