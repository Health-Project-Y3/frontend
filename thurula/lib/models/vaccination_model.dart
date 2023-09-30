class Vaccination {
  String? id;
  String? name;
  String? description;
  //days from birth should be days from conception when considering the mothers vaccines
  int? daysFromBirth;

  Vaccination({this.id, this.name, this.description, this.daysFromBirth});
  static Vaccination fromJson(jsonDecode) {
    return Vaccination(
      id: jsonDecode['id'],
      name: jsonDecode['name'],
      description: jsonDecode['description'],
      daysFromBirth: jsonDecode['daysFromBirth'],
    );
  }

  static Map<String, dynamic> toJson(Vaccination vaccination) {
    return {
      if (vaccination.id != null) 'id': vaccination.id,
      'name': vaccination.name,
      'description': vaccination.description,
      'daysfrombirth': vaccination.daysFromBirth,
    };
  }

  @override
  String toString() {
    return '\nVaccination{id: $id, name: $name, description: $description, daysFromBirth: $daysFromBirth}\n';
  }
}
