import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  User? user = FirebaseAuth.instance.currentUser;

  // Future<String> uploadFile(String email) async {
  //   String refPath = 'userImage/$email/${p.basename(_image.path)}';
  //   Reference? ref = await StroageUtils.uploadFile(_image, refPath);
  //   String? _uploadedFileURL = await ref?.getDownloadURL();
  //   Auth.instance.getCurrentUser().updateProfile(photoURL: _uploadedFileURL);
  //   return _uploadedFileURL ?? "";
  // }

  User? getCurrentUser() {
    user = FirebaseAuth.instance.currentUser;
    return user;
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
