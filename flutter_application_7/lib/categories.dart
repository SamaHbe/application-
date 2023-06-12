import 'package:flutter/material.dart';
import 'package:flutter_application_7/Model/info.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_application_7/catégoriescontrolleur.dart';

class myPage extends StatefulWidget {
  const myPage({super.key});

  @override
  _myPageState createState() => _myPageState();
}

class _myPageState extends State<myPage> {
  MyPageController _controller = MyPageController();

  @override
  Widget build(BuildContext context) {
    List<Info> infoList = _controller.getInfoList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff011638),
        title: const Text(
          "Menu",
          style:
              TextStyle(fontSize: 18, color: Color.fromARGB(255, 252, 116, 25)),
        ),
      ),
      //),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ...infoList.map((val) {
                return Container(
                  child: Card(
                    elevation: 8,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Image.network(
                              val.image,
                              fit: BoxFit.cover,
                              height: 100,
                              width: 100,
                            ),
                            title: Text(
                              val.name,
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 252, 116, 25)),
                            ),
                          ),
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              TextButton(
                                child: const Text(
                                  'choisir',
                                  style: TextStyle(color: Color(0xff011638)),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, val.lientype);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      ),
      //),
    );
  }
}
