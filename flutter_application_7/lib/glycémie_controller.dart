import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GlycemieController extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GlycemieControllerState();
}

class GlycemieControllerState extends State<GlycemieController> {
  var c = Color(0xff011638);
  var d = Color.fromARGB(255, 252, 116, 25);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  final TextEditingController _mesureController = TextEditingController();

  String selectedMeal = '';
  double replaceGlucides = 0.0;
  double ajoutercalcule = 0.0;
  double result = 0.0;
  double number = 0.0;

  @override
  void dispose() {
    _mesureController.dispose();
    super.dispose();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
  }

  notifier() {
    number = double.parse(_mesureController.text);
    if (number < 0.7) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: "Recucrage",
        desc: "Vous devez consimmez une quantité \n de 10 à 15 gramme de sucre",
        //btnCancelOnPress: () {},
        btnOkOnPress: () {
          Color:
          d;
          Title:
          Text(
            "Ok",
            style: TextStyle(fontSize: 20),
          );
          Navigator.pushNamed(context, '/glycemie');
        },
      )..show();
    } else if (number > 2.5) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: "Cas d'urgance",
        desc: "Vous devez consulter votre medecin ",
        //btnCancelOnPress: () {},
        btnOkOnPress: () {
          Color:
          d;
          Title:
          Text(
            "Ok",
            style: TextStyle(fontSize: 20),
          );
          Navigator.pushNamed(context, '/glycemie');
        },
      )..show();
    }
  }

  Future<void> addajoutercalcule(double ajoutercalcule) async {
    try {
      await _firestore
          .collection('Patient')
          .doc(userId)
          .collection('AjouterCalcule')
          .doc()
          .set({
        "ajoutercalcule": ajoutercalcule,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Ajoutercalcule() {
    number = double.parse(_mesureController.text);
    if (number >= 1.3) {
      ajoutercalcule = (number) / 0.3;
    } else {
      ajoutercalcule = 0.0;
    }
    print("ajouter calcule  $ajoutercalcule");
    // return ajoutercalcule;
  }

  void saveValue(double number) async {
    DateTime date = DateTime.now();
    String dateHeure = DateFormat('dd-MM-yy').format(date);
    try {
      await _firestore
          .collection('Patient')
          .doc(userId)
          .collection('Glycémie')
          .doc()
          .set({
        "glycemie": number,
        "Date": dateHeure,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  performCalculation(selectedMeal) {
    if (selectedMeal == 'petit déjeuner') {
      return replaceGlucides = 2.0;

      print('Vous avez sélectionné le petit déjeuner.');
    } else if (selectedMeal == 'déjeuner') {
      return replaceGlucides = 1.0;

      print('Vous avez sélectionné le déjeuner.');
    } else if (selectedMeal == 'dîner') {
      return replaceGlucides = 1.5;

      print('Vous avez sélectionné le dîner.');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
