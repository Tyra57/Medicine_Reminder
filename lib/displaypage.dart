import 'package:flutter/material.dart';

// THIS PAGE IS DONE BY WANI INTENDED TO DISPLAY THE INPUTS FROM THE FORM

class DisplayPage extends StatefulWidget {
  const DisplayPage({Key? key});

  @override
  State<DisplayPage> createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[400],
      ),
      body: Container(
        color: Colors.red[400], 
        child: const SafeArea(
          child: SingleChildScrollView(
            // Content area goes here
            padding: EdgeInsets.all(16.0),
            child: Column(
              // Content widgets
              children: [
                // Your content widgets go here
              ],
            ),
          ),
        ),
      ),
    );
  }
}
