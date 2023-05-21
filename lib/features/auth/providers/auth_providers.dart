//firebase provider
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/features/auth/repositories/repositories.dart';
import 'package:smart_home/features/auth/services/auth_service.dart';
import 'package:smart_home/main.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => auth);

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

final isLoggedIn = StateProvider<bool>((ref) {
  return ref.watch(firebaseAuthProvider).currentUser != null;
});

final currentUserProvider = StateProvider<User?>((ref) {
  return ref.watch(firebaseAuthProvider).currentUser;
});

/*final userDetailsProvider = StateProvider<Map<String, dynamic>?>((ref) {
  return jsonDecode(jsonEncode(ref
      .watch(firestoreProvider)
      .collection('users')
      .doc(ref.watch(firebaseAuthProvider).currentUser?.uid)));
});*/
