class Vaccination {
  String? id;
  String? name;
  String? description;
  int? daysfrombirth;

  Vaccination({this.id, this.name, this.description, this.daysfrombirth});
  static Vaccination fromJson(jsonDecode){
    return Vaccination(
      id: jsonDecode['id'],
      name: jsonDecode['name'],
      description: jsonDecode['description'],
      daysfrombirth: jsonDecode['daysfrombirth'],
    );
  }
  static Map<String,dynamic> toJson(Vaccination vaccination){
    return {
      'id': vaccination.id,
      'name': vaccination.name,
      'description': vaccination.description,
      'daysfrombirth': vaccination.daysfrombirth,
    };
  }

  @override
  String toString() {
    return '\nVaccination{id: $id, name: $name, description: $description, daysfrombirth: $daysfrombirth}\n';
  }
}
