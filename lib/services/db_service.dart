import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ibrahim_sample_project/model/user.dart' as UserModel;

class DBService {
  final FirebaseFirestore _firebaseFirestore;

  DBService(this._firebaseFirestore);

  Future<void> addUser(UserModel.User user) async {
    try {
      await _firebaseFirestore.collection('users').add(user.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<List<UserModel.User>> getUsers() {
    try {
      Stream<QuerySnapshot> stream =
          _firebaseFirestore.collection('users').snapshots();
      return stream.map((qShot) =>
          qShot.docs.map((doc) => UserModel.User.fromSnapshot(doc)).toList());
    } catch (e) {
      print(e.toString());
    }
  }
}
