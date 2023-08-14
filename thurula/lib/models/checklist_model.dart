class Checklists {
  String? id;
  String? period;
  String? category;
  String? instruction;
  bool? checked;

  Checklists({
    this.id='',
    this.period='',
    this.category='',
    this.instruction='',
    this.checked=false,
  });

    static Checklists fromJson(jsonDecode) {
    return Checklists(
      id: jsonDecode['id'],
      period: jsonDecode['period'],
      category: jsonDecode['category'],
      instruction: jsonDecode['instruction'],
      checked: jsonDecode['checked'],
    );
  }
}
