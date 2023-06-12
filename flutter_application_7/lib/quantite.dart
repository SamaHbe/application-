import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_7/Model/quantite_model.dart';
import 'package:flutter_application_7/mesure_sucre.dart';
import 'package:flutter_application_7/quantite_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'dart:convert';

class Quantite extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QuantiteState();
}

class QuantiteState extends State<Quantite> {
  MesureState mesureState = MesureState();
  final _valeurcontroller = TextEditingController();

  QuantiteModel quantiteModel = QuantiteModel();
  late QuantiteController quantiteController;
  //final result = QuantiteController.getResult;
  @override
  void initState() {
    super.initState();
    quantiteController = QuantiteController(quantiteModel, this.context);
  }

  var c = Color.fromARGB(255, 252, 116, 25);
  var d = Color(0xff011638);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff011638),
        title: Text(
          "${quantiteModel.name}",
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 252, 116, 25)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Quantité en gramme: ',
                    style: TextStyle(
                      fontSize: 20,
                      color: d,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  //height: 80,
                  width: 300,
                  alignment: Alignment.bottomLeft,
                  child: TextField(
                    //padding: EdgeInsets.all(16.0),
                    controller: _valeurcontroller,
                    decoration: InputDecoration(
                      hintText: ' Quantité ',
                      hintStyle:
                          TextStyle(fontStyle: FontStyle.italic, fontSize: 20),
                      suffixStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 40,
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(
                  width: 12,
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 220,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: c,
                  shape: StadiumBorder(),
                ),
                child: const Text(
                  'Enregistrer',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff011638),
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    quantiteController.onPressed(
                        _valeurcontroller.text, context);
                  });
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 250,
                    alignment: Alignment.bottomCenter,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(42)),
                      color: Color(0xffFFEEE4),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Image.network(
                          "https://cdn-icons-png.flaticon.com/512/2396/2396713.png",
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CircularPercentIndicator(
                          footer: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Glucides (g)",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 252, 116, 25),
                                  fontSize: 15,
                                )),
                          ),
                          animation: true,
                          animationDuration: 1050,
                          radius: 40,
                          lineWidth: 10.0,
                          percent: quantiteModel.valCircle(),
                          progressColor: Color.fromARGB(255, 252, 116, 25),
                          backgroundColor: Color(0xF8011638),
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text("${quantiteModel.result}",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 252, 116, 25),
                                  fontSize: 20)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  /* CircularPercentIndicator(
                    footer:
                        Text("Insuline", style: TextStyle(color: c, fontSize: 15)),
                    animation: true,
                    animationDuration: 1050,
                    radius: 45,
                    lineWidth: 12.0,
                    percent: valCircle(result),
                    progressColor: Color(0xFFCE6D39),
                    backgroundColor: Color(0xF8011638),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      "$insulineresult",
                      style: TextStyle(fontSize: 20, color: d),
                    ),
                  ),*/

                  Container(
                    alignment: Alignment.bottomCenter,
                    height: 250,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(42)),
                      color: Color(0xffFFEEE4),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Image.network(
                          "https://cdn-icons-png.flaticon.com/512/4264/4264699.png",
                          height: 50,
                          width: 50,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CircularPercentIndicator(
                          footer: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Lipides (g)",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 252, 116, 25),
                                    fontSize: 15)),
                          ),
                          animation: true,
                          animationDuration: 1050,
                          radius: 40,
                          lineWidth: 10.0,
                          percent: quantiteModel.valCircle(),
                          progressColor: Color.fromARGB(255, 252, 116, 25),
                          backgroundColor: Color(0xF8011638),
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Text(
                            "${quantiteModel.lipides}",
                            style: TextStyle(fontSize: 20, color: c),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
