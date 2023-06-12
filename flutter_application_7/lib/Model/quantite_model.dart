import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class QuantiteModel {
  double replaceGlucides = 0.0;
  double number = 0.0;
  double result = 0.0;
  double finalResult = 0.0;
  double lipides = 0.0;
  String name = "Salade mechwia à l'huile";

  double get getResult => result;

  void calculateur(String value) {
    number = double.parse(value);
    result = number / 10;
  }

  double valCircle() {
    return result * 0.005;
  }

  void getLipides(String value) {
    number = double.parse(value);
    lipides = (number * 2) / 10;
    // return lipides;
  }

  // Méthode pour enregistrer la valeur dans la sous-collection
  Future<void> saveData() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    final String date =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";

    try {
      await _firestore
          .collection('Patient')
          .doc(userId)
          .collection('Repas')
          .doc()
          .set({
        "name": name,
        "glucide": result,
        "Lipide": lipides,
        "Date": date,
      });
    } catch (e) {
      // Gérer les erreurs d'enregistrement
      print(e.toString());
    }
  }
}
