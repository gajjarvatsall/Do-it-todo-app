import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();

  Future<void> signInWithGoogle() async {
    try {
      final googleAccount = await googleSignIn.signIn();
      final googleAuth = await googleAccount?.authentication;
      final credential =
          GoogleAuthProvider.credential(idToken: googleAuth?.idToken, accessToken: googleAuth?.accessToken);
      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo?.isNewUser ?? true) {
          {
            await FirebaseFirestore.instance
                .collection("users")
                .doc(user.uid)
                .set({"email": user.email, "name": user.displayName, "profilePic": user.photoURL});
          }
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }
}
