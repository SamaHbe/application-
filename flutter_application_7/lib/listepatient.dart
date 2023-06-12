import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MedecinHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 252, 116, 25),
        backgroundColor: Color(0xff011638),
        title: Text('Listes des patients'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Patient').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Erreur lors du chargement des patients');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> patientData =
                  document.data() as Map<String, dynamic>;
              String patientId = document.id;

              return ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  child: Text(patientData['nom'][0]),
                  backgroundColor: Color(0xffFFEEE4),
                  foregroundColor: Color.fromARGB(255, 252, 116, 25),
                ),
                /* subtitle: Text(
                  patientData['email'],
                  style: TextStyle(fontSize: 10, color: Color(0xff011638)),
                ),*/
                title: Text(
                  patientData['nom'],
                  style: TextStyle(color: Color(0xff011638), fontSize: 20),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GlycemiaPage(patientId: patientId),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class GlycemiaPage extends StatelessWidget {
  final String patientId;

  const GlycemiaPage({required this.patientId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Color.fromARGB(255, 252, 116, 25),
        backgroundColor: Color(0xff011638),
        title: Text('Taux de glycémie'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Patient')
            .doc(patientId)
            .collection('Glycémie')
            .orderBy('Date', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Erreur lors du chargement des taux de glycémie');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.data!.docs.isEmpty) {
            return Text('Aucun taux de glycémie enregistré pour ce patient');
          }

          return ListView(
            children:
                snapshot.data!.docs.take(21).map((DocumentSnapshot document) {
              Map<String, dynamic> glycemiaData =
                  document.data() as Map<String, dynamic>;

              return ListTile(
                leading: Image.network(
                  "https://diabete-enfants.ca/wp-content/uploads/2022/04/Glycemie.png",
                  width: 70,
                  height: 60,
                ),
                title: Text(
                  'Glycémie ${glycemiaData['glycemie']} g/L',
                  style: TextStyle(color: Color(0xff011638), fontSize: 18),
                ),
                subtitle: Text(
                  'Date ${glycemiaData['Date']}',
                  style: TextStyle(
                      color: Color.fromARGB(255, 252, 116, 25), fontSize: 15),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}


























/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/datapatient.dart';

class ListePatient extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ListePatientState();
}

/*
  getData() async {
    CollectionReference userref =
        FirebaseFirestore.instance.collection("Patient");
    QuerySnapshot querySnapshot = await userref.get();
    List<QueryDocumentSnapshot> Listdocs = querySnapshot.docs;
    Listdocs.forEach((element) {
      print(element.data());
    });
   // return Text("element['email']");
  }

  @override
  void initState() {
    getData();
    super.initState();
  }*/
class _ListePatientState extends State<ListePatient> {
  @override
  Widget build(BuildContext context) {
    List allusers = [];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff011638),
        title: const Text(
          "Listes des patients",
          style: TextStyle(fontSize: 18, color: Color(0xFFCE6D39)),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Patient').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur s\'est produite : ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          List dataList = snapshot.data!.docs.map((DocumentSnapshot document) {
            return document.data();
          }).toList();

          return ListView.builder(
            itemCount: dataList.length,
            itemBuilder: (BuildContext context, int index) {
              String userName = dataList[index]['nom'];
              return ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PatientData()),
                    //test
                  );
                },
                leading: CircleAvatar(
                  child: Icon(Icons.person_outline),
                  foregroundColor: Color(0xff011638),
                  backgroundColor: Color(0xffFFEEE4),
                ),
                title: Text(
                  userName,
                  style: TextStyle(fontSize: 20, color: Color(0xFFCE6D39)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
*/