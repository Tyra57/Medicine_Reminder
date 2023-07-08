import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicinereminder/displaypage.dart';
import 'package:medicinereminder/input_field.dart';

// THIS PAGE IS DONE BY WANI AS A CONTINUATION FOR THE MEDICATION FORM

class NextFormPage extends StatefulWidget {
  const NextFormPage({Key? key}) : super(key: key);

  @override
  State<NextFormPage> createState() => _NextFormPageState();
}

class _NextFormPageState extends State<NextFormPage> {
  TextEditingController amountController = TextEditingController(text: "1");
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
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: const Text(
          'Medicine Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
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
                  ),
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
                          Icon(
                            icon,
                            size: 20,
                            color: Colors.black
                          ),
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
                title: "Amount", hint: "Enter the quantity",
                controller: amountController,
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
            const SizedBox(height: 148.0),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DisplayPage(),
                      ),
                    ); 
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(
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
    );
  }
}