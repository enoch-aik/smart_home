import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  FirebaseDatabase databaseRef;

  RealtimeDatabase(this.databaseRef);
//update data on the database
  void write({
    String? path = 'dc',
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref(path);

      await databaseReference.set(data);
    } catch (e) {
      rethrow;
    }
  }

  //Switch the component on or off
  Future<void> setLedState({String? path = 'dc', required int value}) async {
    try {
      DatabaseReference databaseReference = FirebaseDatabase.instance.ref(path);
      await databaseReference.update({'ledstate': value});
    } catch (_) {}
  }
}
