import 'package:flutter/material.dart';
import 'package:flutter_application_7/Model/repas.dart';
import 'package:flutter_application_7/restauration_rapide_controller.dart';

class res_rapide extends StatefulWidget {
  const res_rapide({super.key});

  @override
  _res_rapideState createState() => _res_rapideState();
}

class _res_rapideState extends State<res_rapide> {
  final RestirationRapideController _controller = RestirationRapideController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff011638),
        title: const Text(
          "Créer mon repas ",
          style: TextStyle(fontSize: 18, color: Color(0xFFCE6D39)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ..._controller.li.map((val) {
                return SizedBox(
                  width: 350,
                  height: 90,

                  child: Card(
                    elevation: 8,
                    color: Colors.white,
                    child: TextButton(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              val.name,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xff011638),
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
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
