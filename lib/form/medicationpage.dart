import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicinereminder/form/input_field.dart';
import 'package:medicinereminder/form/nextformpage.dart';
import 'medicationdata.dart';

// THIS PAGE IS DONE BY WANI AND FUNCTIONING AS FORM TO REGISTER MEDICATION

class MedicationPage extends StatefulWidget {
  final MedicationData? medicationData;
  final bool isEditing;

  const MedicationPage({
    Key? key,
    this.medicationData,
    this.isEditing = false,
  }) : super(key: key);

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  final CollectionReference _medicationCollection =
      FirebaseFirestore.instance.collection('medication');

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _dosageController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  late String selectedFrequency = 'Once Daily';
  late final DateTime _selectedDate = DateTime.now();
  late String selectedIntakeTime = 'Anytime';
  String selectedDosageUnit = 'mg';

  late MedicationData medicationData;

  final List<String> dosageUnits = ['mg', 'ml', 'g', 'oz', 'mcg'];

  @override
  void initState() {
    super.initState();

    if (widget.medicationData != null) {
      selectedDosageUnit = widget.medicationData!.dosageUnit;
      _nameController.text = widget.medicationData!.name;
      //_typeController.text = widget.medicationData!.type;
      _dosageController.text = widget.medicationData!.dosage;
    } else {
      selectedDosageUnit = 'mg';
    }
  }

  void updateMedication(Map<String, dynamic> editedMedication) {
    String medicationId = editedMedication['key'];

    _medicationCollection.doc(medicationId).set(editedMedication).then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        elevation: 0,
        title: const Text(
          'Medicine Details',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InputField(
                title: "Medication Name",
                hint: "Enter medication name",
                controller: _nameController,
              ),
              InputField(
                title: 'Type',
                hint: 'Enter medication type',
                isImageField: true,
                controller: _typeController,
              ),
              Stack(
                children: [
                  InputField(
                    title: "Dosage",
                    hint: "Enter dosage",
                    controller: _dosageController,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: const BoxDecoration(
                        border: Border(
                          left: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                      child: DropdownButton<String>(
                        value: selectedDosageUnit,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDosageUnit = newValue!;
                          });
                        },
                        items: dosageUnits.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 70),
              Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Center(
                  child: SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[400],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NextFormPage(
                              medicationData: MedicationData(
                                key: widget.medicationData?.key ?? '',
                                name: _nameController.text,
                                //type: _typeController.text,
                                dosage: _dosageController.text,
                                dosageUnit: selectedDosageUnit,
                                amount: _amountController.text,
                                frequency: selectedFrequency,
                                intakeTime: selectedIntakeTime,
                                date: _selectedDate,
                              ),
                              isEditing: widget.isEditing,
                              updateMedication: updateMedication,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        widget.isEditing ? 'Next' : 'Save',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
