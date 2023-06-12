import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/ajouteraliment_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ajouteraliment extends StatefulWidget {
  final ajouteralimentController controller;

  ajouteraliment({required this.controller});

  @override
  _ajouteralimentState createState() => _ajouteralimentState();
}

class _ajouteralimentState extends State<ajouteraliment> {
  DeleteData() async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    CollectionReference repas = FirebaseFirestore.instance
        .collection("Patient")
        .doc(userId)
        .collection("Repas");

    var value = await repas.get();
    var docId = await value.docs.last.id;

    repas.doc(docId).delete();
  }

  void showDialogWithResult(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Calcule d\'insuline',
            style: TextStyle(color: Color(0xff011638)),
          ),
          content: FutureBuilder<double>(
            future: widget.controller.calculeinsuline(),
            builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Erreur: ${snapshot.error}');
              } else {
                return Container(
                  height: 100,
                  child: Column(
                    children: [
                      Text('Insuline:  ${snapshot.data!.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Color(0xff011638), fontSize: 20)),
                      SizedBox(
                        height: 12,
                      ),
                      TextButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Color.fromARGB(255, 252, 116, 25),
                          ),
                          child: Text("Ok", style: TextStyle(fontSize: 18))),
                    ],
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Color d = Color(0xff011638);
  final String userId = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff011638),
        title: const Text(
          "Liste des aliments",
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 252, 116, 25)),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Color.fromARGB(255, 252, 116, 25),
            ),
            onPressed: () async {
              widget.controller.getCountglucide(widget.controller.ref);
              widget.controller.getCountlipide(widget.controller.ref);
              widget.controller.calculeinsuline();
              showDialogWithResult(context);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Patient")
                      .doc(userId)
                      .collection("Repas")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, int index) {
                        QueryDocumentSnapshot<Map<String, dynamic>> ds =
                            snapshot.data!.docs[index];
                        return Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Card(
                                elevation: 14,
                                color: Colors.white,
                                child: ListTile(
                                  leading: Text(
                                    ds.get("Date"),
                                    style: TextStyle(fontSize: 12, color: d),
                                  ),
                                  title: Text(
                                    ds.get("name"),
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: d,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                      "Glucides ${ds.get("glucide")}",
                                      style: TextStyle(color: Colors.black)),
                                  trailing: IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Color.fromARGB(255, 252, 116, 25),
                                    ),
                                    onPressed: () {
                                      DeleteData();
                                    },
                                  ),
                                ),

                                // Text(ds["Lipides"].toString()),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  }),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 252, 116, 25),
        foregroundColor: Colors.black,
        label: Text('Ajouter a la liste'),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/categories',
          );
        },
        icon: Icon(Icons.add),
      ),
    );
  }
}










/* double insulineresult = 0.0;
  double plus = 0.0;

  getGlucide() async {
    CollectionReference ajoutercalcule = FirebaseFirestore.instance
        .collection("Patient")
        .doc(userId)
        .collection("AjouterCalcule");
    var repas = await ajoutercalcule.get();
    var ajouterId = await repas.docs.last.id;
    var ajoutcal = await ajoutercalcule.doc(ajouterId).get();
    double plusinsuline = ajoutcal["ajoutercalcule"];
    print("ajoutcal: $plusinsuline");
    CollectionReference choixrepas = FirebaseFirestore.instance
        .collection("Patient")
        .doc(userId)
        .collection("choixrepas");
    var value = await choixrepas.get();
    var docId = await value.docs.last.id;
     .collection("Patient")
        .doc(userId)
        .collection('Repas');
    var glu = await gluciderepas.get();
    var gluId = await glu.docs.last.id;
    var getglu = await gluciderepas.doc(gluId).get();
    // return val["ajoutercalcule"];
    var glucide = getglu["glucide"];
    print("nombre de glucide");var val = await choixrepas.doc(docId).get();
    double choix = val["choixrepas"];
    print("choix: $choix");
    print("choixrepas");
    CollectionReference gluciderepas = FirebaseFirestore.instance
       
    setState(() {
      insulineresult = ((glucide * choix) / 10) + plusinsuline;
    });
    // print(insulineresult);
    return insulineresult;
  }
*/

  /* insuline(double glucide, double choix) {
    setState(() {
      insulineresult = ((glucide * choix) / 10);
    });
    print("$insulineresult");
  }*/




  /* double glucideresult = 0.0;
  getglucide() async {
    CollectionReference glucidecalcule = FirebaseFirestore.instance
        .collection("Patient")
        .doc(userId)
        .collection("Repas");
    QuerySnapshot repasSnapshot = await glucidecalcule.get();
    if (repasSnapshot != null) {
      List<QueryDocumentSnapshot> repasDocuments = repasSnapshot.docs;
      double glucideresult = 0.0;
      for (var repasDocument in repasDocuments) {
        var repas = await glucidecalcule.get();
        var glucideId = await repas.docs.last.id;
        var glucide = await glucidecalcule.doc(glucideId).get();
        double glucideresult = glucide["glucide"];
        print("ssssssssssssssss");
        print("ajoutcal: $glucideresult");
        glucideresult += glucideresult;
        print("teree $glucideresult");
      }
      //glucideresult += glucideresult;
      //print("$glucideresult");
    }
  }*/