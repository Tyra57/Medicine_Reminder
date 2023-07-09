import 'package:flutter/material.dart';
import 'package:medicinereminder/form/medicationReminderPage.dart';

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  void _setReminder() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MedicationReminderPage()),
    );
  }

  void _saveDetails() {
    // Save the details
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Details Saved'),
          content: const Text('Your details have been saved.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text('Details Display'),
        actions: [
          IconButton(
            onPressed: _setReminder,
            icon: const Icon(Icons.add_alarm),
          ),
          IconButton(
            onPressed: _saveDetails,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        /*child: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Your content widgets go here
              ],
            ),
          ),
        ),*/
      ),
    );
  }
}
