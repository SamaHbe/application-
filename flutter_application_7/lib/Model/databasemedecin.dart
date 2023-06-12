import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseMedecin {
  final String? uid;
  String? nom;

  String? email;
  String? password;
  DataBaseMedecin({
    this.uid,
    this.nom,
    this.email,
    this.password,
  });
  final CollectionReference medecinCollection =
      FirebaseFirestore.instance.collection("Patient");
  Future<void> savePatient(
    String email,
    String password,
    String nom,
  ) async {
    return await medecinCollection.doc(uid).set({
      'email': email,
      'password': password,
      "nom": nom,
    });
  }

  final CollectionReference MedecinCollection =
      FirebaseFirestore.instance.collection("Medecin");
  Future<void> saveMedecin(
    String email,
    String password,
    String nom,
  ) async {
    return await MedecinCollection.doc(uid).set({
      'email': email,
      'password': password,
      "nom": nom,
    });
  }
}
