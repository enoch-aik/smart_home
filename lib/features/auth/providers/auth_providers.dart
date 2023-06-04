//firebase provider
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/features/auth/repositories/repositories.dart';
import 'package:smart_home/features/auth/services/auth_service.dart';
import 'package:smart_home/main.dart';

//Firebase authentication provider
final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => auth);

//Firebase storage provider
final firestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

//auth repo

final authRepoProvider = Provider((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  final firestore = ref.watch(firestoreProvider);
  return AuthRepository(firebaseAuth: firebaseAuth, firestore: firestore);
});

final authServiceProvider = ChangeNotifierProvider((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return AuthService(authRepo);
});

//This boolean is used to get there is a current user, this is true if there is a current user and false if there is no current user
final isLoggedIn = StateProvider<bool>((ref) {
  return ref.watch(firebaseAuthProvider).currentUser != null;
});

//This is used to get the details of the current User, if there is no user, this would be null
final currentUserProvider = StateProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).currentUser;
});

