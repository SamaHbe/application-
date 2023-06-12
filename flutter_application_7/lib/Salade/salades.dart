import 'package:flutter/material.dart';
import 'package:flutter_application_7/Model/repas.dart';
import 'package:flutter_application_7/salade_controller.dart';

class salades extends StatefulWidget {
  const salades({super.key});

  @override
  _saladesState createState() => _saladesState();
}

class _saladesState extends State<salades> {
  final SaladesController _controller = SaladesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff011638),
        title: const Text(
          "Créer mon repas ",
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 132, 60, 13)),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ..._controller.li.map((val) {
                return SizedBox(
                  width: double.infinity,
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
                        print(val.name);
                        print(val.name);
                        Navigator.pushNamed(
                          context,
                          val.lien,
                        );
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
