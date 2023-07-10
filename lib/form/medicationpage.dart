import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicinereminder/form/input_field.dart';
import 'package:medicinereminder/form/nextformpage.dart';

// THIS PAGE IS DONE BY WANI AND FUNCTIONING AS FORM TO REGISTER MEDICATION

class MedicationPage extends StatefulWidget {
  const MedicationPage({Key? key}) : super(key: key);

  @override
  State<MedicationPage> createState() => _MedicationPageState();
}

class _MedicationPageState extends State<MedicationPage> {
  TextEditingController medicationNameController = TextEditingController();
  String selectedDosageUnit = 'mg';
  TextEditingController dosageController = TextEditingController();
  String selectedImage = 'tablet';


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
                  title: "Medication Name", hint: "Enter medication name",
                  controller: medicationNameController,),
              const InputField(
                  title: 'Type',
                  hint: 'Enter medication type',
                  isImageField: true,
                  ),
              const InputField(
                title: "Dosage",
                hint: "Enter dosage",
              ),
              const SizedBox(height: 70.0),
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
                      onPressed: () async {
                        await FirebaseFirestore.instance.collection('medication').add({
                          'medicationName': medicationNameController.text,
                          'dosage': dosageController.toString(),
                          'dosageUnit': selectedDosageUnit,
                          'selectedImage': selectedImage,
                        });

                          // ignore: use_build_context_synchronously
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
      ),
    );
  }
}
