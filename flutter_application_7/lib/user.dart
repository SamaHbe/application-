class Utilisateur {
  String? nom;

  String? email;
  String? password;
  String? uid;

  Utilisateur({
    this.nom,
    this.email,
    this.password,
    this.uid,
  });
  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'id': uid,
      'password': password,
      'email': email,
    };
  }

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      uid: json['id'],
      email: json['email'],
      password: json['password'],
      nom: json['nom'],
    );
  }
}


/*class DataBase {
  final String? uid;
  final String email;
  final double? mesure;
  final String nom;
  DataBase({
    required this.nom,
    this.uid,
    required this.email,
    this.mesure,
  });
}
*/