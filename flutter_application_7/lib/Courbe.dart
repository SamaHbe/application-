import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatelessWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: LiveChart());
  }
}

class LiveChart extends StatefulWidget {
  const LiveChart({Key? key}) : super(key: key);

  @override
  _LiveChartState createState() => _LiveChartState();
}

class _LiveChartState extends State<LiveChart> {
  List<_ChartData> chartData = <_ChartData>[];
  var d = Color(0xff011638);
  void initState() {
    super.initState();
    getDataFromFireStore();
  }

  @override
  Future<void> getDataFromFireStore() async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    var snapShotsValue = await FirebaseFirestore.instance
        .collection("Patient")
        .doc(userId)
        .collection("Glycémie")
        .limit(10)
        .orderBy('Date', descending: false)
        .get();
    List<_ChartData> list = snapShotsValue.docs.map((e) {
      final x = e.get('Date');
      final y = e.get('glycemie').toDouble();
      print("========================");
      print(
          'Data - x: $x, y: $y'); // Ajoutez cette ligne pour afficher les données récupérées
      return _ChartData(
        x: x,
        y: y,
      );
    }).toList();
    setState(() {
      chartData = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showChart();
  }

  Widget _showChart() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Courbe de glycémie",
          style: TextStyle(color: Color.fromARGB(255, 252, 116, 25)),
        ),
        backgroundColor: Color(0xff011638),
      ),
      body: Container(
        color: Color(0xffFFEEE4),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
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
                  yValueMapper: (_ChartData data, _) => data.y,
                  markerSettings: MarkerSettings(
                    isVisible: true, // Afficher les marqueurs
                    shape: DataMarkerType
                        .circle, // Modifier la forme des marqueurs (croix)
                    borderWidth: 2,
                  ),
                ),
              ],
            ),
            /*  TextButton(
                onPressed: () {
                  getDataFromFireStore();
                },
                child: Text("hello"))*/
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData({this.x, this.y});
  final String? x;
  final double? y;
}







/*import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FirestoreLineChart extends StatefulWidget {
  @override
  _FirestoreLineChartState createState() => _FirestoreLineChartState();
}

class _FirestoreLineChartState extends State<FirestoreLineChart> {
  Future<List<DocumentSnapshot>> fetchDataFromFirestore() async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('Patient')
        .doc(userId)
        .collection('glycémie')
        .get();
    return querySnapshot.docs;
  }

  List<ChartData> convertDataToChartData(List<DocumentSnapshot> data) {
    List<ChartData> chartData = [];

    for (int i = 0; i < data.length; i++) {
      double x = i.toDouble(); // Axe x
      double y = data[i].get(
          'mesure'); // Axe y (à remplacer par le nom du champ contenant les valeurs)

      chartData.add(ChartData(x, y));
    }

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DocumentSnapshot>>(
      future: fetchDataFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erreur: ${snapshot.error}');
        } else {
          List<ChartData> chartData = convertDataToChartData(snapshot.data!);
          return SfCartesianChart(
            primaryXAxis: NumericAxis(),
            primaryYAxis: NumericAxis(),
            series: <ChartSeries>[
              LineSeries<ChartData, double>(
                dataSource: chartData,
                xValueMapper: (ChartData data, _) => data.x,
                yValueMapper: (ChartData data, _) => data.y,
              ),
            ],
          );
        }
      },
    );
  }
}

class ChartData {
  final double x;
  final double y;

  ChartData(this.x, this.y);
}
*/