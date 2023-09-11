class Vaccination {
  String? id;
  String? name;
  String? description;
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
      'id': vaccination.id,
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
