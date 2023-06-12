import 'package:flutter/material.dart';
import 'package:flutter_application_7/Model/repas.dart';

class produit_sucres extends StatefulWidget {
  const produit_sucres({super.key});

  @override
  _produit_sucresState createState() => _produit_sucresState();
}

class _produit_sucresState extends State<produit_sucres> {
  final List<Repas> li = [
    Repas(name: "Aspatame, Candys ", lien: '/mekla'),
    Repas(name: "Cacao amer en poudre", lien: '/Salha'),
    Repas(name: "Chamia", lien: '/mandba.dart'),
    Repas(name: "Chocolat en poudre", lien: '/sakhta'),
    Repas(name: "Chocolat noir, blanc, au lait", lien: '/sakhta'),
    Repas(name: "Chocolat noir, blanc, au lait sans sucre", lien: '/sakhta'),
    Repas(name: "Chocolat à tartiner", lien: '/sakhta'),
    Repas(name: "Confiture", lien: '/sakhta'),
    Repas(name: "Confiture allégée", lien: '/sakhta'),
    Repas(name: "Miel", lien: '/sakhta'),
    Repas(name: "Sucre (sacharose)", lien: '/sakhta'),
    Repas(name: "Sucre", lien: '/sakhta'),
    Repas(name: "Sucre blanc ou roux ", lien: '/sakhta'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff011638),
        title: const Text(
          "Créer mon repas ",
          style: TextStyle(fontSize: 18, color: Color(0xFFCE6D39)),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
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
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ...li.map((val) {
                return SizedBox(
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
                              style: const TextStyle(
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
