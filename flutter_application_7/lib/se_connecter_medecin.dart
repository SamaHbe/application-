import 'package:flutter_application_7/listepatient.dart';
import 'package:flutter_application_7/services/authontification.dart';
import 'package:flutter/material.dart';

class Seconnectermed extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SeconnectermedState();
}

class _SeconnectermedState extends State<Seconnectermed> {
  final AuthontificationService _auth = AuthontificationService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool showSignIn = true;
  // bool loading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var c = Color(0xff011638);

  bool passwordVisible = true;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void toggleView() {
    setState(() {
      _emailController.text = '';
      _passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Demande Connexion',
          style: TextStyle(color: Color.fromARGB(255, 252, 116, 25)),
        ),
        //foregroundColor: Color(0xff011638),
        backgroundColor: Color(0xff011638),
      ),
      body: Container(
        height: double.infinity,
        // margin: EdgeInsets.fromLTRB(40, 175, 40, 175),
        //color: Color(0xffFFEEE4),
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              //width: double.infinity,

              child: Column(
                // key: _formKey,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Title(
                            color: c,
                            child: Text(
                              'Medecin',
                              style: TextStyle(
                                  fontSize: 25,
                                  color: c,
                                  fontWeight: FontWeight.w500),
                            )),
                        Container(
                          alignment: Alignment.center,
                          width: 300,
                          height: 120,
                          child: TextFormField(
                            validator: (value) =>
                                value!.isEmpty ? "Entrez  un email" : null,
                            controller: _emailController,
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: c),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              labelText: 'E-mail',
                              labelStyle: TextStyle(fontSize: 20, color: c),
                              hintText: "Tapez Votre E-mail ",
                              hintStyle: TextStyle(fontSize: 20, color: c),
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
                                ? "entrez un mot de passe qui depasse 6 caractére"
                                : null,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.red, width: 2.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 2, color: c),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              labelText: 'Mot de Passe',
                              labelStyle: TextStyle(fontSize: 20, color: c),
                              hintText: "Tapez Votre Mot de passe ",
                              hintStyle: TextStyle(fontSize: 20, color: c),
                              suffixIcon: IconButton(
                                icon: Icon(passwordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                color: c,
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
                      primary: c,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/mdpoublier');
                    },
                    child: Text('mot de passe oublier'),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: c,
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/create_med');
                    },
                    child: const Text('créer un compte'),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 6),
                    width: 300,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 252, 116, 25),
                        shape: StadiumBorder(),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            // loading = true;
                          });
                          var password = _passwordController.value.text;
                          var email = _emailController.value.text;

                          dynamic result =
                              _auth.signInWithEmailAndPassword(email, password);

                          /*  if (result == null) {
                            setState(() {
                              // loading = false;
                              error = "Please supply a valid email";
                            });
                          }*/
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MedecinHomePage()),
                        );
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
                  const SizedBox(
                    height: 10,
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
