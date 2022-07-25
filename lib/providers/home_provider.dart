import 'package:cloud_firestore/cloud_firestore.dart';

class HomeProvider {
  final firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUsers() {
    return firestore.collection('users').limit(20).snapshots();
  }
}
