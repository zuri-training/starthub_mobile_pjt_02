import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class CloudStorageService {
  Future<CloudStorageResult> uploadImage({
    @required File imageToUpload,
    @required String title,
  }) async {
    var imageFileName =
        title + DateTime.now().millisecondsSinceEpoch.toString();

    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);

    UploadTask uploadTask = firebaseStorageRef.putFile(imageToUpload);

    TaskSnapshot storageSnapshot = await uploadTask.snapshot;

    var downloadUrl = await storageSnapshot.ref.getDownloadURL();

    if (uploadTask != null) {
      var url = downloadUrl.toString();
      return CloudStorageResult(
        imageUrl: url,
        imageFileName: imageFileName,
      );
    }

    return null;
  }

  Future deleteImage(String imageFileName) async {
    final Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child(imageFileName);

    try {
      await firebaseStorageRef.delete();
      return true;
    } catch (e) {
      return e.toString();
    }
  }
}

class CloudStorageResult {
  final String imageUrl;
  final String imageFileName;

  CloudStorageResult({this.imageUrl, this.imageFileName});
}