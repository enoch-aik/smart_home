import 'package:firebase_database/firebase_database.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:smart_home/features/home/repositories/database_crud.dart';

final databaseRefProvider = Provider((ref) => FirebaseDatabase.instance);

final realtimeDatabaseProvider =
    Provider((ref) => RealtimeDatabase(ref.watch(databaseRefProvider)));

final dcStreamProvider =
    StreamProvider.family<DatabaseEvent, String>((ref, path) {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref(path);
  return databaseReference.onValue;
});
final acStreamProvider =
    StreamProvider.family<DatabaseEvent, String>((ref, path) {
  DatabaseReference databaseReference = FirebaseDatabase.instance.ref(path);
  return databaseReference.onValue;
});
