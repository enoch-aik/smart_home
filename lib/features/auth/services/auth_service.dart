import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_home/features/auth/models/user.dart';
import 'package:smart_home/features/auth/repositories/repositories.dart';

//This is the authentication service for the application
//This is more of a class that indirectly implements all the functions in AuthRepo
class AuthService extends ChangeNotifier {
  final AuthRepository authRepo;

  AuthService(this.authRepo);

  ///signUpWithEmailAndPassword
  Future signUpWithEmailAndPassword({required UserReqModel user}) async {
    try {
      return await authRepo.signUpWithEmailAndPassword(user: user);
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'Error creating account, try again';
    }
  }

  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      return await authRepo.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'Failed to login, try again';
    }
  }

  Future forgotPassword(String email) async {
    try {
      await authRepo.forgotPassword(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (_) {
      return 'Failed to process request, try again';
    }
  }

  Future googleSignIn() async {
    try {
      UserCredential? credential = await authRepo.googleSignIn();
      User? user = credential?.user;
      if (user != null) {
        UserReqModel newUser = UserReqModel(
          email: user.email,
          fullName: user.displayName,
          userId: user.uid,
        );
        await authRepo.storeUserDetails(newUser);
        return user;
      }
      }
      on FirebaseAuthException catch (e){
      return e.message;
      }
      catch (_) {
      return 'Failed to sign in with Google, try again';
    }
  }

  Future<bool> storeUserDetails(UserReqModel user) async {
    try {
      return await authRepo.storeUserDetails(user);
    } catch (_) {
      return false;
    }
  }
}
