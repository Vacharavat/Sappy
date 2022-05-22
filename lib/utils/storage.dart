import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StroageUtils {
  static Future<Reference?> uploadFile(File file, String refPath) async {
    try {
      if (file.existsSync()) {
        Reference storageReference = FirebaseStorage.instance.ref().child(refPath);
        return storageReference.putFile(file).then((TaskSnapshot snapshot) => snapshot.ref);
      }
      return null;
    } catch (err) {
      rethrow;
    }
  }
}
