import 'package:fl_chart/fl_chart.dart';

import 'package:flutter_application_7/Oeufs/oeufdur.dart';
import 'package:flutter_application_7/Salade/salade_verte.dart';
import 'package:flutter_application_7/accueil.dart';
import 'package:flutter_application_7/datapatient.dart';
import 'package:flutter_application_7/glaces/zgougou_sans_decoration.dart';
import 'package:flutter_application_7/glycemie.dart';
import 'package:flutter_application_7/listepatient.dart';
import 'package:flutter_application_7/mdpoublier.dart';
import 'package:flutter_application_7/Pain%20et%20Assimil%C3%A9s/pain.dart';
import 'package:flutter_application_7/patisserie.dart';
import 'package:flutter_application_7/laitages.dart';
import 'package:flutter_application_7/assaisonnements_condiments.dart';
import 'package:flutter_application_7/boisson_sucre.dart';
import 'package:flutter_application_7/boisson_alcool.dart';
import 'package:flutter_application_7/boisson_non_sucre.dart';
import 'package:flutter_application_7/create_med.dart';
import 'package:flutter_application_7/create_patient.dart';
import 'package:flutter_application_7/creux_sales.dart';
import 'package:flutter_application_7/creux_sucres.dart';
import 'package:flutter_application_7/desserts.dart';
import 'package:flutter_application_7/glaces/entrements_glaces.dart';
import 'package:flutter_application_7/fromage.dart';
import 'package:flutter_application_7/choix.dart';
import 'package:flutter_application_7/categories.dart';
import 'package:flutter_application_7/mesure_sucre.dart';
import 'package:flutter_application_7/Oeufs/oeufs.dart';
import 'package:flutter_application_7/plats_com.dart';
import 'package:flutter_application_7/poissons.dart';
import 'package:flutter_application_7/produits_sucres.dart';
import 'package:flutter_application_7/restauration_rapide.dart';
import 'package:flutter_application_7/Salade/salades.dart';
import 'package:flutter_application_7/se_connecter_medecin.dart';
import 'package:flutter_application_7/se_connecter_patient.dart';
import 'package:flutter_application_7/soupes_potages.dart';
import 'package:flutter_application_7/viandes_abats.dart';
import 'package:flutter_application_7/volailles.dart';
import 'package:flutter_application_7/quantite.dart';
import 'package:flutter_application_7/ajouteraliment/ajouteraliment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Choix(),
      routes: {
        '/glycemie': (context) => Glycemie(),
        '/laitages': (context) => laitages(),
        '/patisseuries': (context) => const Patisserie(),
        '/assaisonnements_condiments': (context) =>
            assaisonnements_condiments(),
        '/desserts': (context) => const desserts(),
        '/entrements_glaces': (context) => const entrements_glaces(),
        '/produit_sucres': (context) => const produit_sucres(),
        '/creux_salés': (context) => const creux_sales(),
        '/creux_sucrés': (context) => const creux_sucres(),
        '/restauration_rapide': (context) => const res_rapide(),
        '/boisons_sucré': (context) => const BoissonsSucre(),
        '/boissons_alcool': (context) => const Alcool(),
        '/boissons_non_sucré': (context) => const BoissonsNonSucree(),
        '/poissons': (context) => const Poissons(),
        '/pain': (context) => const Pain(),
        '/formage': (context) => const Fromage(),
        '/viandes_abats': (context) => const viandesAbats(),
        '/volailles': (context) => const volailles(),
        '/oeufs': (context) => const oeufs(),
        '/plats_ com': (context) => const plats(),
        '/soupes_potages': (context) => const soupes(),
        '/categories': (context) => const myPage(),
        '/quantite': (context) => Quantite(),
        '/se_connecter_medecin': (context) => Seconnectermed(),
        '/create_med': (context) => const CreateMed(),
        '/create_patient': (context) => const CreatePat(),
        '/calcule': (context) => const myPage(),
        '/salades': (context) => const salades(),
        '/zgougou_sans_decorations': (context) => Zegougou(),
        '/accueil': (context) => Acceuil(),
        '/oeufdur': (context) => Oeufdur(),
        '/salade_verte': (context) => SaladeVert(),
        '/mdpoublier': (context) => oublier(),
      },
    );
  }
}
