import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider {
  final instance = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUsers() {
    return instance.collection('users').limit(20).snapshots();
  }
}
