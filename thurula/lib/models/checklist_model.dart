class Instruction {
  final String? instruction;
  final bool checked;

  Instruction({required this.instruction, required this.checked});

  factory Instruction.fromJson(Map<String, dynamic> json) {
    return Instruction(
      instruction: json['instructionText'],
      checked: json['checked'],
    );
  }
}

class Checklists {
  String? id;
  String? period;
  String? category;
  final List<Instruction> instructions;

  Checklists({
    this.id = '',
    this.period = '',
    this.category = '',
    required this.instructions,
  });

  factory Checklists.fromJson(Map<String, dynamic> json) {
    final List<dynamic> instructionsJson = json['instructions'];

    final List<Instruction> instructions = instructionsJson.map((item) {
      return Instruction.fromJson(item);
    }).toList();

    return Checklists(
      id: json['_id'],
      period: json['period'],
      category: json['category'],
      instructions: instructions,
    );
  }
}
