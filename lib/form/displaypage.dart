import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// THIS PAGE IS DONE BY WANI INTENDED TO DISPLAY THE INPUTS FROM THE FORM

class DisplayPage extends StatefulWidget {
  final String medicationName;
  final String dosageValue;
  final String dosageUnit;
  final String amount;
  final String frequency;
  final String selectedImage;
  final String intakeTime;
  final DateTime selectedDate;
  

  const DisplayPage({
    Key? key,
    required this.medicationName,
    required this.dosageValue,
    required this.dosageUnit,
    required this.amount,
    required this.frequency,
    required this.selectedImage,
    required this.intakeTime,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<DisplayPage> createState() => _DisplayPageState();
  
}

class _DisplayPageState extends State<DisplayPage> {
  late String imagePath;

  @override
  void initState() {
    super.initState();
     imagePath = widget.selectedImage;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red[400],
      ),
      body: Container(
        color: Colors.red[400],
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                '${widget.medicationName} - ${widget.dosageValue} ${widget.dosageUnit}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Amount: ${widget.amount}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              Text(
                'Frequency: ${widget.frequency}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                margin: const EdgeInsets.all(10.0),
                child:   imagePath.isNotEmpty
                    ? Image.asset(
                        imagePath,
                        width: 40,
                        height: 40,
                      )
                    : const SizedBox(),
              ),

              const SizedBox(height: 16.0),
              Text(
                'Intake Time: ${widget.intakeTime}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                'Date: ${DateFormat.yMd().format(widget.selectedDate)}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
