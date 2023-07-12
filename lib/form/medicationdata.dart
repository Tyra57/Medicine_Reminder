
class MedicationData {
  final String key;
  final String name;
  //final String type;
  final String dosage;
  final String dosageUnit;
  final String amount;
  final String frequency;
  final String intakeTime;
  final DateTime date;

  MedicationData({
    required this.key,
    required this.name,
    //required this.type,
    required this.dosage,
    required this.dosageUnit,
    required this.amount,
    required this.frequency,
    required this.intakeTime,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      //'type': type,
      'dosage': dosage,
      'dosageUnit': dosageUnit,
      'amount': amount,
      'frequency': frequency,
      'intakeTime': intakeTime,
      'date': date,
    };
  }
}
