import 'package:flutter/material.dart';
import 'package:medicinereminder/displaypage.dart';
import 'package:medicinereminder/input_field.dart';

class MedicationPage extends StatefulWidget {
  const MedicationPage({super.key});

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Details',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputField(title: "Medication Name", hint: "Enter medication name"),
            InputField(title: "Type", hint: ""),
          ],
        ),
      ),
    );
  }
}