import 'package:flutter/material.dart';
import 'package:flutter_application_7/Model/quantite_model.dart';
import 'package:flutter_application_7/ajouteraliment/ajouteraliment.dart';
import 'package:flutter_application_7/ajouteraliment_controller.dart';

class QuantiteController {
  final ajouteralimentController controller = ajouteralimentController();
  final QuantiteModel model;

  QuantiteController(this.model, this.context);
  BuildContext context;
  void handleButtonPressed(String value, context) {
    model.calculateur(value);
    model.getLipides(value);
    model.saveData();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ajouteraliment(controller: controller)),
      //test
    );
  }

  void onPressed(String value, BuildContext context) {
    handleButtonPressed(value, context);
  }
}
