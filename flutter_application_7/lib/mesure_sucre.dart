import 'package:flutter_application_7/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Mesure extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MesureState();
}

class MesureState extends State<Mesure> {
  @override
  String selectedMeal = '';

  void _selectMeal(String meal) {
    setState(() {
      selectedMeal = meal;
    });
    // Effectuer votre calcul ici en utilisant la variable selectedMeal
    // Par exemple, vous pouvez appeler une fonction qui effectue le calcul
    performCalculation(replaceGlucides);
  }

  double replaceGlucides = 0.0;
  performCalculation(replaceGlucides) {
    // Faites votre calcul en utilisant la variable selectedMeal
    // Par exemple :

    if (selectedMeal == 'petit déjeuner') {
      replaceGlucides = 2.0;

      return replaceGlucides;
      print('Vous avez sélectionné le petit déjeuner.');
      // Effectuez votre calcul pour le petit déjeuner ici
    } else if (selectedMeal == 'déjeuner') {
      replaceGlucides = 1.0;

      return replaceGlucides;
      print('Vous avez sélectionné le déjeuner.');
      // Effectuez votre calcul pour le déjeuner ici
    } else if (selectedMeal == 'dîner') {
      replaceGlucides = 1.5;

      return replaceGlucides;
      print('Vous avez sélectionné le dîner.');
      // Effectuez votre calcul pour le dîner ici
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

  calcule() {
    result = 0.0;
    number = double.parse(_mesureController.text);
    if (number > 1.3 && number < 1.7) {
      result += 1;
      addmesure();
      // print("$result");
    } else if (number > 1.6 && number < 2) {
      result += 2;
      addmesure();
      //print("$result");
    } else if (number >= 2) {
      result += 3;
      addmesure();
      //print("$result");
    }
  }

  addmesure() async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection("Patient");
    QuerySnapshot querySnapshot = await userRef.get();
    if (querySnapshot != null) {
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;
      for (var document in documents) {
        CollectionReference mesureRef = FirebaseFirestore.instance
            .collection("Patient")
            .doc(document.id)
            .collection("Glycémie");
        mesureRef.add({
          "mesure": number,
          // "result": result,
        });
      }
    }
  }

  /* void addmesure(Utilisateur user, double number) {
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('user');
    DocumentReference userDocRef = usersCollection.doc(user.uid);
    CollectionReference subCollection = userDocRef.collection('glycémie');
    subCollection.add({
      'glycémie': number,
    }).then((value) {
      print('Utilisateur ajouté à la sous-collection avec ID : ${value.id}');
    }).catchError((error) {
      print(
          'Erreur lors de l\'ajout de l\'utilisateur à la sous-collection : $error');
    });
  }*/

  /* void addmesure() async {
    CollectionReference userCollection =
        FirebaseFirestore.instance.collection('user');
    userCollection.add({
      'number': number,
      'result': result,
    });
  }*/

  var c = Color(0xff011638);
  var d = Color(0xfffec8c9);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 9,
                  ),
                  Container(
                    width: 110,
                    child: ElevatedButton(
                      onPressed: () => _selectMeal('petit déjeuner'),
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
                      onPressed: () => _selectMeal('déjeuner'),

                      // _selectMeal('déjeuner'),
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
                      onPressed: () => _selectMeal('dîner'),

                      // _selectMeal('dîner'),
                      child: Text(
                        'Dîner',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 150.0),
                alignment: Alignment.center,
                child: Text(
                  'Glycémie',
                  style: TextStyle(
                    fontSize: 30,
                    color: c,
                  ),
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: c),
                      borderRadius: BorderRadius.all(Radius.circular(600)),
                    ),
                    hintText: '0.0',
                    hintStyle:
                        TextStyle(fontStyle: FontStyle.italic, fontSize: 40),
                    suffixText: 'mg/dL',
                    suffixStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 40,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStatePropertyAll(EdgeInsets.all(10)),
                      backgroundColor: MaterialStatePropertyAll(d),
                      foregroundColor: MaterialStatePropertyAll(c),
                    ),
                    child: const Text('Enregistrer'),
                    onPressed: () async {
                      final User? _user = FirebaseAuth.instance.currentUser;

                      addmesure();
                      calcule();
                      performCalculation(replaceGlucides);
                      Navigator.pushNamed(context, '/Calendrier');
                    },
                  ),
                  // ),
                ],
              ),
              Container(
                child: Text(
                  "$result",
                  style: TextStyle(fontSize: 40),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:flutter_application_7/lineChart.dart';
import 'package:flutter_application_7/pricePoints.dart';

class Mesure extends StatefulWidget {
  const Mesure({super.key});

  @override
  State<StatefulWidget> createState() => _MesureState();
}

class _MesureState extends State<Mesure> {
  var c = const Color(0xff011638);
  var d = Color.fromARGB(255, 252, 116, 25);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff011638),
          title: const Text(
            "Mesure",
            style: TextStyle(fontSize: 18, color: Color(0xFFCE6D39)),
          ),
        ),
        body: Container(
          // mainAxisAlignment: MainAxisAlignment.center,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                content(),
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Glycémie',
                    style: TextStyle(
                      fontSize: 30,
                      color: c,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 250,
                  margin: const EdgeInsets.only(bottom: 50.0),
                  alignment: Alignment.center,
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: '0.0',
                      hintStyle:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 40),
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
                      style: ButtonStyle(
                        padding:
                            const MaterialStatePropertyAll(EdgeInsets.all(10)),
                        backgroundColor: MaterialStatePropertyAll(d),
                        foregroundColor: MaterialStatePropertyAll(c),
                      ),
                      child: const Text('Enregistrer'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/categories');
                      },
                    ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget content() {
    return Container(
      margin: const EdgeInsets.only(top: 100.0),
      child: LineChartWidget(pricePoints),
    );
  }
}
*/
