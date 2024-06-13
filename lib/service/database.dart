import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethod {
  Future addUserDetail (Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
    .collection("users")
    .doc(id)
    .set(userInfoMap);
  }

  UpdateUserwallet (String id, String amount) async{
    return await FirebaseFirestore.instance
    .collection("users")
    .doc(id)
    .update({"Wallet": amount});
  }

  Future addShoeToCart (Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
    .collection("users")
    .doc(id)
    .collection("Cart")
    .add(userInfoMap);
  }

  Future<Stream<QuerySnapshot>> getShoeCart (String id) async{
    return await FirebaseFirestore.instance
    .collection("users")
    .doc(id)
    .collection("Cart")
    .snapshots();
  }

  Future<Stream<QuerySnapshot>> getShoeItem (String name) async{
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

  Future<Stream<QuerySnapshot>> getShoeMoreItem (String name) async{
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

}