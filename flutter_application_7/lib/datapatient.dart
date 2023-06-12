import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PatientData extends StatefulWidget {
  const PatientData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: PatientData());
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _PatientDataState extends State<PatientData> {
  List<_ChartData> chartData = <_ChartData>[];
  var d = Color(0xff011638);
  String selectedPatientId =
      ""; // Ajoutez cette variable pour stocker l'ID du patient sélectionné

  void initState() {
    super.initState();
    // Par défaut, sélectionnez le premier patient dans la liste des patients du médecin
    if (chartData.isNotEmpty) {
      selectedPatientId = chartData[0].patientId!;
    }
    getDataFromFirestore();
  }

  @override
  Future<void> getDataFromFirestore() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String userId = FirebaseAuth.instance.currentUser!.uid;

    // Vérifiez si un patient est sélectionné, puis récupérez les données de la sous-collection "Glycémie" de ce patient
    if (selectedPatientId.isNotEmpty) {
      var snapshotsValue = await FirebaseFirestore.instance
          .collection("Medecin")
          .doc(userId)
          .collection("Patient")
          .doc(selectedPatientId)
          .collection("Glycémie")
          .get();
      List<_ChartData> list = snapshotsValue.docs.map((e) {
        final x = e.get('Date');
        final y = e.get('glycemie').toDouble();
        print("========================");
        print('Data - x: $x, y: $y');
        return _ChartData(
          x: x,
          y: y,
          patientId: selectedPatientId,
        );
      }).toList();
      setState(() {
        chartData = list;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _showChart();
  }

  Widget _showChart() {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          // Affichez ici la liste des patients du médecin et permettez au médecin de sélectionner un patient
          // Lorsque le médecin sélectionne un patient, mettez à jour la variable selectedPatientId et appelez getDataFromFirestore()

          SfCartesianChart(
            tooltipBehavior: TooltipBehavior(enable: true),
            primaryXAxis: CategoryAxis(
              majorGridLines: MajorGridLines(color: d),
              majorTickLines: MajorTickLines(color: d),
            ),
            primaryYAxis: NumericAxis(
              majorGridLines: MajorGridLines(color: d),
              majorTickLines: MajorTickLines(color: d),
            ),
            series: <LineSeries<_ChartData, String>>[
              LineSeries<_ChartData, String>(
                  color: Color.fromARGB(255, 252, 116, 25),
                  dataSource: chartData,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChartData {
  _ChartData({this.x, this.y, this.patientId});
  final String? x;
  final double? y;
  final String? patientId;
}
