/*import 'package:flutter_application_7/services/database.dart';
//import 'package:flutter_application_7/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future ajouterUtilisateur(DataBase user) async {
  final docUser = FirebaseFirestore.instance.collection("user").doc();
  user.uid = docUser.id;
  await docUser.set(user);
}
*/