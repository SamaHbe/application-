import 'package:awesome_dialog/awesome_dialog.dart';
//import 'package:baaaaaaa333/ajoutermedecin.dart';
//import 'package:baaaaaaa333/ajouterutilisateur.dart';
//import 'package:baaaaaaa333/model/user.dart';
import 'package:flutter_application_7/services/authontification.dart';
//import 'package:baaaaaaa333/services/database.dart';

//import 'package:baaaaaaa333/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:baaaaaaa333/user.dart';

//import 'package:flutter/create_acount_med.dart';
/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(CreatePat());
}*/

class CreateMed extends StatefulWidget {
  const CreateMed({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateMedState();
}

class _CreateMedState extends State<CreateMed> {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();

  final nomController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmerpasswordController = TextEditingController();
  final AuthontificationService _auth = AuthontificationService();

  final _formKey1 = GlobalKey<FormState>();
  String error = '';
  String message = '';
  bool showSignIn = true;
  //bool loading = false;
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmerpasswordController.dispose();
  }

  void toggleView() {
    setState(() {
      emailController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

  addData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;
    CollectionReference patientref =
        FirebaseFirestore.instance.collection("Medecin");
    patientref.add({
      "nom": "${nomController.text.trim()}",
      "email": "${emailController.text.trim()}",
      "password": "${passwordController.text.trim()}",
    });
  }

  /* Future SignUp() async {
    User? user = FirebaseAuth.instance.currentUser;

    /* if (user != null && !user.emailVerified) {
      var actionCodeSettings = ActionCodeSettings(
        url: 'https://www.example.com/?email=${user.email}',
        dynamicLinkDomain: 'example.page.link',
        androidPackageName: 'com.example.android',
        androidInstallApp: true,
        androidMinimumVersion: '12',
        iOSBundleId: 'com.example.ios',
        handleCodeInApp: true,
      );

      await user.sendEmailVerification(actionCodeSettings);
    }*/
    try {
      // if (verifyEmail() == true) {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .then((value) => verifyEmail());
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Oppppps',
          desc: ' le mot de passe est court ',
          //btnCancelOnPress: () {},
          btnOkOnPress: () {
            Title:
            " se conncter";
            // Navigator.pushNamed(context, '/mesure_sucre');
          },
        )..show();
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Opps',
          desc: ' vous avez déja un compte',
          //btnCancelOnPress: () {},
          btnOkOnPress: () {
            Color:
            d;
            Title:
            " se conncter";
            Navigator.pushNamed(context, '/se_connecter_patient');
          },
        )..show();
        print('The account already exists for that email.');
        /* } else if ( //_passwordController.text.trim() ==
          e.code == "vérifier votre mot de passe") {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'succès',
          desc: "le mot de passe n'st validé ",
          //btnCancelOnPress: () {},
          btnOkOnPress: () {
            Title:
            " se conncter";
            Navigator.pushNamed(context, '/mesure_sucre');
          },
        )..show();*/
      }
    } catch (e) {
      print(e);
    }
  }*/

  verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;
    /*  if (!(passwordController.text.trim() ==
        confirmerpasswordController.text.trim())) {
    /*  AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Opps',
        desc: 'essayer de valider votre mot de passe',
        //btnCancelOnPress: () {},
        btnOkOnPress: () {
          Color:
          d;
          Title:
          " se conncter";
          Navigator.pushNamed(context, '/se_connecter_patient');
        },
      )..show();*/
    } else if*/
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }
  /* await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim());
    Navigator.of(context).pushNamed("/");
    try {
      _passwordController.text.trim() ==
          _confirmerpasswordController.text.trim();
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'succès',
        desc: ' le mot de passe est validé ',
        //btnCancelOnPress: () {},
        btnOkOnPress: () {
          Title:
          " se conncter";
          Navigator.pushNamed(context, '/mesure_sucre');
        },
      )..show();
    }
    //catch (FirebaseAuthException) {
    catch (FirebaseAuthException) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Opps',
        desc: 'essayez de valider votre mot de passe',
        //btnCancelOnPress: () {},
        btnOkOnPress: () {
          /* Color:
          d;*/
          Title:
          " se conncter";
          Navigator.pushNamed(context, '/create_patient');
        },
      )..show();
    }*/
  //}
  /*  try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim());
    } catch (FirebaseAuthException) {
      return AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.rightSlide,
        title: 'Opps',
        desc: ' vous avez déja un compte',
        //btnCancelOnPress: () {},
        btnOkOnPress: () {
          Color:
          d;
          Title:
          " se conncter";
          Navigator.pushNamed(context, '/se_connecter_patient');
        },
      )..show();
    }*/

  // }

  /*  AwesomeDialog passwordConfirmed() {
      if (_passwordController.text.trim() ==
          _confirmerpasswordController.text.trim()) {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'succès',
          desc: ' le mot de passe est valide ',
          //btnCancelOnPress: () {},
          btnOkOnPress: () {
            Color:
            d;
            Title:
            " se conncter";
            Navigator.pushNamed(context, '/se_connecter_patient');
          },
        )..show();
      } else {
        return AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.rightSlide,
          title: 'Opps',
          desc: 'essayer de valider votre mot de passe',
          //btnCancelOnPress: () {},
          btnOkOnPress: () {
            Color:
            d;
            Title:
            " se conncter";
            Navigator.pushNamed(context, '/se_connecter_patient');
          },
        )..show();
      }
    }
  }
*/
  /* @override
    void dispose() {
      super.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _confirmerpasswordController.dispose();
    }*/

  var c = Color(0xff011638);
  var d = Color(0xFFe77e4d);
  bool passwordVisible = true;
  //late UserCredential userCredential;

  // var myname, mypassword, myemail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff011638),
        title: const Text(
          'Créer un compte',
          style: TextStyle(
            fontSize: 19.0,
            color: Color.fromARGB(255, 252, 116, 25),
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 40.0, left: 30.0, right: 30.0),
            // height: 25,
            child: Form(
              key: _formKey1,
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Tapez votre nom " : null,
                    controller: nomController,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: c),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      // border: OutlineInputBorder(),
                      labelText: 'Nom',
                      labelStyle: TextStyle(fontSize: 20, color: c),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) =>
                        value!.isEmpty ? "Entrez  un email valide" : null,
                    controller: emailController,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: c),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      // border: OutlineInputBorder(),
                      labelText: 'Email',
                      labelStyle: TextStyle(fontSize: 20, color: c),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (value) => value!.length < 6
                        ? "entrez un mot de passe qui depasse 6 caractére"
                        : null,
                    controller: passwordController,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red, width: 2.0)),
                      // border: OutlineInputBorder(),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: c),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
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
                      labelText: ' Mot de Passe',
                      labelStyle: TextStyle(fontSize: 20, color: c),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  /* TextFormField(
                    validator: (value) => value!.length < 6
                        ? "entrez un mot de passe qui depasse 6 caractére "
                        : null,
                    controller: confirmerpasswordController,
                    decoration: InputDecoration(
                      errorBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.red, width: 2.0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 2, color: c),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      //border: OutlineInputBorder(),
                      labelText: 'Confirmer le Mot de Passe',
                      labelStyle: TextStyle(fontSize: 20, color: c),
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
                  ),
                  */
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 6),

                    width: 300,
                    // height: 35,
                    // padding: EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey1.currentState!.validate()) {
                          setState(() {
                            //  loading = true;
                          });
                          var password = passwordController.value.text;
                          var email = emailController.value.text;
                          var nom = nomController.value.text;
                          dynamic result =
                              _auth.registerWithEmailAndPasswordMedecin(
                                  email, password, nom);
                          dynamic verif = _auth.verifyEmail();

                          if (result != null && verif != null) {
                            error = 'vous avez reçus un email de confirmation';
                            addData();
                            Future.delayed(Duration(seconds: 4), () {
                              Navigator.pushNamed(
                                  context, '/se_connecter_medecin');
                            });
                          } /*else {
                            addData();
                          }*/
                        }
                      },
                      //},

                      // verifyEmail();
                      //verifyEmail();
                      /* if (verifyEmail()) {
                          error = "vous avez reçus un email de confirmation";
                        } else if (verifyEmail() == true) {
                          Navigator.pushNamed(context, '/acceuil');
                        }*/
                      // Navigator.pushNamed(context, '/se_connecter_patient');
                      // SignUp();

                      // passwordController.text = '';
                      //},

                      /* if (!(passwordController.text.trim() ==
                            confirmerpasswordController.text.trim())) {
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.rightSlide,
                            title: 'Opps',
                            desc: 'essayer de valider votre mot de passe',
                            //btnCancelOnPress: () {},
                            btnOkOnPress: () {
                              Color:
                              d;
                              Title:
                              " se conncter";
                              Navigator.pushNamed(
                                  context, '/se_connecter_patient');
                            },
                          )..show();
                        } else {*/
                      // verifyEmail();
                      // error = 'vous avez reçus un email de confirmation';
                      //} // Navigator.pushNamed(context, '/se_connecter_patient');
                      //};
                      //},

                      child: const Text(
                        'Créer',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Color(0xFF011638)),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromARGB(255, 252, 116, 25),
                        shape: StadiumBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(error,
                      style: TextStyle(
                          color: d, fontSize: 15, fontWeight: FontWeight.bold)),
                  /*  SizedBox(
                    height: 10,
                  ),
                  Text(message,
                      style: TextStyle(
                          color: d, fontSize: 15, fontWeight: FontWeight.bold)),*/
                  /*  GestureDetector(
                  onTap: SignUp,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: d,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: const Text(
                        'créer',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 30),
                      ),
                    ),
                  ),
                ),*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
//}
