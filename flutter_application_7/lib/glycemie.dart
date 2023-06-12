import 'package:intl/intl.dart';
import 'package:flutter_application_7/categories.dart';
import 'package:flutter_application_7/quantite.dart';
import 'package:flutter_application_7/services/authontification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class Glycemie extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GlycemieState();
}

class GlycemieState extends State<Glycemie> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String selectedMeal = '';
  static double ajouter = 0.0;

  double _selectMeal(
    String meal,
  ) {
    setState(() {
      performCalculation(meal);
      selectedMeal = meal;
    });
    return replaceGlucides;
  }

  double replaceGlucides = 0.0;
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

  final _mesureController = TextEditingController();

  double result = 0.0, number = 0.0;
  void dispose() {
    _mesureController.dispose();
    super.dispose();
  }

  void initFirebase() async {
    await Firebase.initializeApp();
  }

  double ajoutercalcule = 0.0;
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

  Future<void> addajouter(double ajouter) async {
    try {
      await _firestore
          .collection('Patient')
          .doc(userId)
          .collection('choixrepas')
          .doc()
          .set({
        "choixrepas": ajouter,
      });
    } catch (e) {
      print(e.toString());
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<void> saveValue(double number) async {
    DateTime Date = DateTime.now();
    String dateHeure = DateFormat('dd-MM-yy').format(Date);
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

  var c = Color(0xff011638);
  var d = Color.fromARGB(255, 252, 116, 25);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Glycémie",
          style: TextStyle(color: Color.fromARGB(255, 252, 116, 25)),
        ),
        backgroundColor: Color(0xff011638),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 110,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(42)),
                  color: Color(0xffFFEEE4),
                ),
                //color: Color(0xffFFEEE4),
                height: 400,
                width: 300,
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Glycémie',
                      style: TextStyle(
                        fontSize: 30,
                        color: c,
                      ),
                    ),
                    Container(
                      height: 150,
                      width: 250,
                      margin: EdgeInsets.only(top: 15.0),
                      alignment: Alignment.center,
                      child: TextField(
                        //padding: EdgeInsets.all(16.0),
                        controller: _mesureController,
                        decoration: InputDecoration(
                          hintText: '0.0',
                          hintStyle: TextStyle(
                              fontStyle: FontStyle.italic, fontSize: 30),
                          suffixText: 'mg/dL',
                          suffixStyle: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 30,
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          child: const Text('Enregistrer'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 252, 116, 25),
                            foregroundColor: Color(0xff011638),
                          ),
                          onPressed: () async {
                            addajouter(ajouter);
                            Ajoutercalcule();

                            notifier();
                            addajoutercalcule(ajoutercalcule);
                            saveValue(number);
                            performCalculation(replaceGlucides);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => myPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    width: 110,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 252, 116, 25),
                        foregroundColor: Color(0xff011638),
                      ),
                      onPressed: () {
                        setState(() {
                          ajouter = _selectMeal('petit déjeuner');
                          print(ajouter);
                        });
                      },
                      child: Text(
                        'Petit déjeuner',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 110,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 252, 116, 25),
                        foregroundColor: Color(0xff011638),
                      ),
                      onPressed: () {
                        setState(() {
                          ajouter = _selectMeal('déjeuner');
                          print(ajouter);
                        });
                      },
                      child: Text(
                        'Déjeuner',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    width: 110,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 252, 116, 25),
                        foregroundColor: Color(0xff011638),
                      ),
                      onPressed: () {
                        setState(() {
                          ajouter = _selectMeal('dîner');
                          print(ajouter);
                        });
                      },
                      child: Text(
                        'Dîner',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
