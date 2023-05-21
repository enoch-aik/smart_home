

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_home/features/auth/models/user.dart';

class AuthRepository {
  const AuthRepository({required this.firebaseAuth, required this.firestore});

  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  Future<UserReqModel> signUpWithEmailAndPassword(
      {required UserReqModel user}) async {
    UserCredential newUser = await firebaseAuth.createUserWithEmailAndPassword(
        email: user.email!, password: user.password!);
    user.userId = newUser.user?.uid;
    return user;
  }

  Future<UserCredential> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> forgotPassword({required String email}) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<UserCredential?> googleSignIn() async {

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // get auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // when signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<bool> storeUserDetails(UserReqModel user) async {
    await firestore.collection('users').doc(user.userId).set(user.toJson());
    return true;
  }
}