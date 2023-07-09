
import 'package:flutter/material.dart';
import 'package:medicinereminder/calendar.dart';
import 'package:medicinereminder/main.dart';

// THIS PAGE IS DONE BY WANI AND SUPPOSED TO BE NEXT AFTER LOGIN AND REGISTRATION PAGE

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
          color: Colors.black,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/medicine.jpg',
            height: 300,
            width: 300,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: const Text(
                'Stay on Track with Your Medication Schedule',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 23,
                  color: Colors.black
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text(
                'Set personalized reminders, track your medication intake, and stay on top of your health effortlessly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
            const SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 50.0), 
              child: SizedBox(
                width: 180,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[400],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CalendarPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          //  _signOutButton(),
          ],
        ),
      ),
    );
  }
}

