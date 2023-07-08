import 'package:flutter/material.dart';
import 'package:medicinereminder/input_field.dart';
import 'package:medicinereminder/nextform.dart';

// THIS PAGE IS DONE BY WANI AND FUNCTIONING AS FORM TO REGISTER MEDICATION

class MedicationPage extends StatefulWidget {
  const MedicationPage({Key? key}) : super(key: key);

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text(
          'Medicine Details',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InputField(
                title: "Medication Name", hint: "Enter medication name"),
            const InputField(
                title: 'Type',
                hint: 'Enter medication type',
                isImageField: true),
            const InputField(
              title: "Dosage",
              hint: "Enter dosage",
            ),
            const SizedBox(height: 90.0),
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
                          builder: (context) => const NextFormPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
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
    );
  }
}
