import 'package:cloud_firestore/cloud_firestore.dart';

class DataBase {
  final String? uid;
  String? nom;

  String? email;
  String? password;
  DataBase({
    this.uid,
    this.nom,
    this.email,
    this.password,
  });
  final CollectionReference patientCollection =
      FirebaseFirestore.instance.collection("Patient");
  Future<void> savePatient(
    String email,
    String password,
    String nom,
  ) async {
    return await patientCollection.doc(uid).set({
      'email': email,
      'password': password,
      "nom": nom,
    });
  }

  final CollectionReference MedecinCollection =
      FirebaseFirestore.instance.collection("Patient");
  Future<void> saveMedecin(
    String email,
    String password,
    String nom,
  ) async {
    return await patientCollection.doc(uid).set({
      'email': email,
      'password': password,
      "nom": nom,
    });
  }
}
