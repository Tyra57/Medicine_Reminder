import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicinereminder/form/calendarpage.dart';
import 'package:medicinereminder/form/input_field.dart';

import 'medicationdata.dart';

// THIS PAGE IS DONE BY WANI AS A CONTINUATION FOR THE MEDICATION FORM

class NextFormPage extends StatefulWidget {
  final MedicationData medicationData;
  final bool isEditing;
  final String? medicationId; 
  final Function(Map<String, dynamic>) updateMedication; 

  const NextFormPage({
    Key? key,
    required this.medicationData,
    this.isEditing = false, this.medicationId, required this.updateMedication,
  }) : super(key: key);

  @override
  State<NextFormPage> createState() => _NextFormPageState();
}

class _NextFormPageState extends State<NextFormPage> {
  final CollectionReference _medicationCollection =
      FirebaseFirestore.instance.collection('medication');

  TextEditingController _amountController = TextEditingController(text: "1");
  String selectedFrequency = 'Once Daily';
  DateTime _selectedDate = DateTime.now();
  String selectedIntakeTime = 'Anytime';

  final List<String> frequencyOptions = [
    'Once Daily',
    'Twice Daily',
    'Three Times Daily',
    'Four Times Daily',
  ];

  final List<String> intakeTimeOptions = [
    'Anytime',
    'Morning',
    'Evening',
    'Night',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.red,
            colorScheme: const ColorScheme.light(primary: Colors.red),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }


  @override
  void initState() {
    super.initState();

    if (widget.isEditing) {
      selectedFrequency = widget.medicationData.frequency;
      selectedIntakeTime = widget.medicationData.intakeTime;
      _amountController.text = widget.medicationData.amount;
      _selectedDate = widget.medicationData.date;
    } else {
      _amountController = TextEditingController(text: "1");
      selectedFrequency = 'Once Daily';
      _selectedDate = DateTime.now();
      selectedIntakeTime = 'Anytime';
    }
  }

  void updateMedication() {
    final editedMedication = MedicationData(
      key: widget.medicationData.key,
      name: widget.medicationData.name,
      //type: widget.medicationData.type,
      dosage: widget.medicationData.dosage,
      dosageUnit: widget.medicationData.dosageUnit,
      amount: _amountController.text,
      frequency: selectedFrequency,
      intakeTime: selectedIntakeTime,
      date: _selectedDate,
    );

    widget.updateMedication(
        editedMedication.toMap()); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        elevation: 0,
        title: const Text(
          'Medicine Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Frequency',
                        hintText: 'Select medication frequency',
                        labelStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    value: selectedFrequency,
                    onChanged: (newValue) {
                      setState(() {
                        selectedFrequency = newValue!;
                      });
                    },
                    items: frequencyOptions.map((option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Intake Time',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Select intake time',
                    ),
                    value: selectedIntakeTime,
                    onChanged: (newValue) {
                      setState(() {
                        selectedIntakeTime = newValue!;
                      });
                    },
                    items: intakeTimeOptions.map((option) {
                      IconData icon;
                      switch (option) {
                        case 'Morning':
                          icon = Icons.wb_sunny_outlined;
                          break;
                        case 'Evening':
                          icon = Icons.cloud_outlined;
                          break;
                        case 'Night':
                          icon = Icons.nights_stay_outlined;
                          break;
                        default:
                          icon = Icons.access_time_outlined;
                      }
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Row(
                          children: [
                            Icon(icon, size: 20, color: Colors.black),
                            const SizedBox(width: 8),
                            Text(option),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              InputField(
                title: "Amount",
                hint: "Enter the quantity",
                controller: _amountController,
                inputType: TextInputType.number,
              ),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  InputField(
                    title: "Date",
                    hint: DateFormat.yMd().format(_selectedDate),
                  ),
                  Positioned(
                    right: 8.0,
                    bottom: 4.0,
                    child: IconButton(
                      icon: const Icon(Icons.calendar_today_outlined),
                      color: Colors.grey[600],
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 140.0),
              Center(
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
                   onPressed: () async {
                      final updatedMedicationData = MedicationData(
                        key: widget.medicationData.key,
                        name: widget.medicationData.name,//type: widget.medicationData.type,
                        dosage: widget.medicationData.dosage,
                        dosageUnit: widget.medicationData.dosageUnit,
                        amount: _amountController.text,
                        frequency: selectedFrequency,
                        intakeTime: selectedIntakeTime,
                        date: _selectedDate,
                      );

                      if (widget.isEditing) {
                        await _medicationCollection
                            .doc(widget.medicationId)
                            .update(updatedMedicationData.toMap());
                      } else {
                        await _medicationCollection
                            .add(updatedMedicationData.toMap());
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CalendarPage(),
                        ),
                      );
                    },


                    child: Text(
                      widget.isEditing ? 'Update' : 'Add',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
