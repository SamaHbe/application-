import 'package:flutter_application_7/accueil.dart';
import 'package:flutter_application_7/create_patient.dart';
import 'package:flutter_application_7/se_connecter_patient_controller.dart';
import 'package:flutter_application_7/services/authontification.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart'; //
import 'firebase_options.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SeconnecterPatient extends StatefulWidget {
  final SeconnecterPatientController controller; // Ajouter cette ligne

  SeconnecterPatient({required this.controller});
  @override
  State<StatefulWidget> createState() => _SeconnecterPatientState();
}

class _SeconnecterPatientState extends State<SeconnecterPatient> {
  SeconnecterPatientController _controller = SeconnecterPatientController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool passwordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demande Connexion'),
        foregroundColor: Color.fromARGB(255, 252, 116, 25),
        backgroundColor: Color(0xff011638),
      ),
      body: Container(
        height: double.infinity,
        // color: Color(0xffFFEEE4),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: widget.controller.formKey,
                    child: Column(
                      children: [
                        Title(
                            color: _controller.c,
                            child: Text(
                              'Patient',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: _controller.c,
                                  fontWeight: FontWeight.w500),
                            )),
                        Container(
                          alignment: Alignment.center,
                          width: 300,
                          height: 120,
                          child: TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? "Entrez  un email" : null,
                            controller: _controller.emailController,
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: _controller.c),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              labelText: 'E-mail',
                              labelStyle:
                                  TextStyle(fontSize: 20, color: _controller.c),
                              hintText: "Tapez Votre E-mail ",
                              hintStyle:
                                  TextStyle(fontSize: 20, color: _controller.c),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 120,
                          alignment: Alignment.center,
                          child: TextFormField(
                            validator: (value) => value!.length < 6
                                ? "Entrez un mot de passe qui depasse 6 caractére"
                                : null,
                            controller: _controller.passwordController,
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 2, color: _controller.c),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              labelText: 'Mot de Passe',
                              labelStyle:
                                  TextStyle(fontSize: 20, color: _controller.c),
                              hintText: "Tapez Votre Mot de passe ",
                              hintStyle:
                                  TextStyle(fontSize: 20, color: _controller.c),
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                color: _controller.c,
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                            obscureText: passwordVisible,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: _controller.c, // foreground
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/mdpoublier');
                    },
                    child: Text('Mot de passe oublier'),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 15, 10, 6),
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 252, 116, 25),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () async {
                        _controller.signIn(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Acceuil()),
                          //test
                        );

                        /*if (_controller.formKey.currentState!.validate()) {
                          setState(() {
                            // loading = true;
                          });
                          var password = passwordController.value.text;
                          var email = _emailController.value.text;

                          dynamic result =
                              _auth.signInWithEmailAndPassword(email, password);

                          if (result == null) {
                            setState(() {
                              error = "Please supply a valid email";
                            });
                          } else {
                            Navigator.pushReplacementNamed(context, '/accueil');
                          }
                        
                        }
                        ;*/
                      },
                      child: const Text(
                        'Se connecter',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color(0xFF011638)),
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: _controller.c, // foreground
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/create_patient');
                      // resetPass();
                    },
                    child: const Text('Créer un compte'),
                  ),
                  Container(
                    child: Text(
                      _controller.error,
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




  //SignIn();
                      /*    dynamic result = await _auth.signInAnon();
                            if (result == null) {
                              print("erreur");
                            } else {
                              print(result);
                            }*/


  /*else if (emailVerified == true) {
                            // Connexion réussie, naviguez vers l'écran suivant

                            Navigator.pushReplacementNamed(context, '/acceuil');
                          } else {
                            // Affichez un message d'erreur indiquant que l'e-mail n'est pas vérifié
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Erreur de connexion'),
                                  content: Text(
                                      'Veuillez vérifier votre e-mail pour continuer.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }*/


  /* Future SignIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
      Navigator.of(context).pushNamed("/");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Opps',
          desc: "vous n'avez pas un compte",
          //btnCancelOnPress: () {},
          btnOkOnPress: () {
            /* Color:
          d;*/
            Title:
            " se conncter";
            Navigator.pushNamed(context, '/create_patient');
          },
        )..show();
        // print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Opps',
          desc: 'le mot de passe est incorrect',
          //btnCancelOnPress: () {},
          btnOkOnPress: () {
            /* Color:
          d;*/
            Title:
            " j'ai l'oublier";
            Navigator.pushNamed(context, '/ss');
          },
        )..show();
        //print('Wrong password provided for that user.');
      }
    }
  }*/
