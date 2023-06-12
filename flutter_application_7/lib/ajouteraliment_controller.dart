import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_7/ajouteraliment/ajouteraliment.dart';
import 'package:flutter_application_7/Model/ajouteraliment_model.dart';

class ajouteralimentController {
  CollectionReference ref = FirebaseFirestore.instance.collection("Patient");
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  getCountglucide(CollectionReference ref) async {
    // Sum the count of each shard in the subcollection
    final repas = await ref.doc(userId).collection("Repas").get();

    double glucideCount = 0;

    repas.docs.forEach(
      (doc) {
        glucideCount += doc.data()['glucide'] as double;
      },
    );

    return glucideCount;
  }

  getCountlipide(CollectionReference ref) async {
    final repas = await ref.doc(userId).collection("Repas").get();

    double lipidCount = 0;

    repas.docs.forEach(
      (doc) {
        lipidCount += doc.data()['Lipide'] as double;
      },
    );

    return lipidCount;
  }

  getajoutercalcule() async {
    CollectionReference ajouteraliment = FirebaseFirestore.instance
        .collection("Patient")
        .doc(userId)
        .collection("AjouterCalcule");
    var value = await ajouteraliment.get();
    var lastdocId = await value.docs.last.id;
    var val = await ajouteraliment.doc(lastdocId).get();
    double plusinsuline = val["ajoutercalcule"];
    return plusinsuline;
  }

  getrepaschoix() async {
    CollectionReference choixrepas = FirebaseFirestore.instance
        .collection("Patient")
        .doc(userId)
        .collection("choixrepas");
    var value = await choixrepas.get();
    var docId = await value.docs.last.id;
    var val = await choixrepas.doc(docId).get();
    double choix = val["choixrepas"];
    return choix;
  }

  //double countglucide = 0.0;
  //double insuline = 0.0;
  Future<double>? calculeinsuline() async {
    double countglucide = await getCountglucide(ref);
    print("totale glucide   $countglucide");
    double countlipide = await getCountlipide(ref);
    print("totale lipide   $countlipide");
    double ajoutercalcule = await getajoutercalcule();
    print("ajoutercalcule   $ajoutercalcule");
    double repaschoix = await getrepaschoix();
    print("repaschoix   $repaschoix");
    double insuline = ((countglucide * repaschoix) / 10) + ajoutercalcule;

    if (countglucide > 120) {
      insuline += 2;
    } else if (countlipide > 40) {
      insuline += 2;
    } else {
      insuline = insuline;
    }
    return insuline;
  }
}
