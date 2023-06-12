import 'package:flutter/material.dart';
import 'package:flutter_application_7/Model/repas.dart';

class assaisonnements_condiments extends StatefulWidget {
  @override
  _assaisonnements_condimentsState createState() =>
      new _assaisonnements_condimentsState();
}

class _assaisonnements_condimentsState
    extends State<assaisonnements_condiments> {
  final List<Repas> li = [
    Repas(name: "Ail, épices et aromates", lien: '/mekla'),
    Repas(name: "Beurre, margarine", lien: '/Salha'),
    Repas(name: "Crème fraiche 30% MG", lien: '/mandba.dart'),
    Repas(name: "Huile (toutes les huiles)", lien: '/sakhta'),
    Repas(name: "Mayonnaise", lien: '/sakhta'),
    Repas(name: "Moutarde", lien: '/sakhta'),
    Repas(name: "Oignon", lien: '/sakhta'),
    Repas(name: "Smen", lien: '/sakhta'),
    Repas(name: "Vinaigrette", lien: '/sakhta'),
    Repas(name: "Vinaigrette allégée", lien: '/sakhta'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff011638),
        title: const Text(
          "Créer mon repas ",
          style: TextStyle(fontSize: 18, color: Color(0xFFCE6D39)),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: Color(0xFFCE6D39),
            ),
            onPressed: () {
              /*  showSearch(
                context: context,
                delegate: MySearchDelegate(),
              );*/
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ...li.map((val) {
                return Container(
                  width: 350,
                  height: 90,

                  child: Card(
                    elevation: 8,
                    color: Colors.white,
                    child: TextButton(
                      // padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            /*leading: Image.network(
                                val.image,
                              ),*/
                            title: Text(
                              val.name,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff011638),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),

                          /* Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                TextButton(
                                  child: const Text(
                                    'choisir',
                                    style: TextStyle(color: Color(0xff011638)),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, val.lien);
                                  },
                                ),
                              ],
                            ),*/
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, val.lien);
                      },
                    ),
                  ),
                  // ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
