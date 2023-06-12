import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_7/Model/database.dart';
import 'package:flutter_application_7/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_7/Model/databasemedecin.dart';

class AuthontificationService {
  var message = '';
  // final CreatePat _pat = CreatePat();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Utilisateur utilisateur = Utilisateur();
  Utilisateur? userFormFirebaseUser(User? user) {
    return user != null ? Utilisateur(uid: user.uid, email: user.email) : null;
  }

  Stream<Utilisateur?> get user {
    return _auth.authStateChanges().map(userFormFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = result.user!;
      if (result.user != null) {
        if (result.user!.emailVerified == true) {
          return
              // L'e-mail de l'utilisateur est vérifié, v'ous pouvez poursuivre la connexion
              print('Connexion réussie');
        } else {
          print("probléme de connexion ");
        }
      }

      return userFormFirebaseUser(user);
    } catch (exception) {
      message = 'vous avez déja un compte';
      print(exception.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(
      String email, String password, String nom) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DataBase(uid: user!.uid).savePatient(email, password, nom);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = "le mot de passe doit déppasser 6 ";
      } else if (e.code == 'email-already-in-use') {
        message = "vous avez déja un compte";
      }
    }
  }

  Future registerWithEmailAndPasswordMedecin(
      String email, String password, String nom) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      await DataBaseMedecin(uid: user!.uid).saveMedecin(email, password, nom);
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = "le mot de passe doit déppasser 6 ";
      } else if (e.code == 'email-already-in-use') {
        message = "vous avez déja un compte";
      }
    }
  }

  Future<void> verifyEmail() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
        print(
            'Un e-mail de vérification a été envoyé à ${user.email}. Veuillez vérifier votre boîte de réception.');
      } catch (error) {
        print("Erreur lors de l'envoi de l'e-mail de vérification : $error");
      }
    } else {
      print('Aucun utilisateur connecté ou l\'e-mail a déjà été vérifié.');
    }
  }

  /* Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }*/
}
