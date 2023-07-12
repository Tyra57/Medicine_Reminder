import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:medicinereminder/form/medicationReminderPage.dart';
import 'package:medicinereminder/form/medicationpage.dart';
import 'package:medicinereminder/homePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'medicationdata.dart';

// THIS PAGE IS DONE BY WANI AND INTENDED TO DISPLAY THE DATA

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<Map<String, dynamic>> medicationDetails = [];

  final CollectionReference _medication =
      FirebaseFirestore.instance.collection('medication');

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> _deleteMedication(String medicationId) async {
    await _medication.doc(medicationId).delete();
  }

  void updateMedication(Map<String, dynamic> editedMedication) {
    String medicationId = editedMedication['key'];

    _medication
        .doc('medicationDetails')
        .collection('medication')
        .doc(medicationId)
        .update(editedMedication)
        .then((_) {
      setState(() {
        int medicationIndex = medicationDetails
            .indexWhere((medication) => medication['key'] == medicationId);
        if (medicationIndex != -1) {
          medicationDetails[medicationIndex] = editedMedication;
        }
      });
      showMessage('Medication updated successfully!');
    }).catchError((error) {
      showMessage('Failed to update medication: $error');
    });
  }

  void fetchUserDetails() {
    _medication.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          Map<dynamic, dynamic>? values =
              documentSnapshot.data() as Map<dynamic, dynamic>?;
          if (values != null) {
            setState(() {
              medicationDetails.add({
                ...Map<String, dynamic>.from(values),
                'id': documentSnapshot.id,
              });
            });
          }
        }
      });
    });
  }


  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SplashScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.red[400],
            ),
            onPressed: () {
               Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MedicationReminderPage()),
            );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.yMMMM().format(DateTime.now()),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 20),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: const Color(0xFFEF5350),
                selectedTextColor: Colors.white,
                dateTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
                monthTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                dayTextStyle: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              child: const Text(
                'Medicines',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _medication.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return Expanded(
                    child: Container(
                      color: Colors.red[400],
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: streamSnapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          final DocumentSnapshot documentSnapshot =
                              streamSnapshot.data!.docs[index];
                          final MedicationData medicationData = MedicationData(
                            name: documentSnapshot['name'],
                            //type: documentSnapshot['type'],
                            dosage: documentSnapshot['dosage'],
                            dosageUnit: documentSnapshot['dosageUnit'],
                            amount: documentSnapshot['amount'],
                            frequency: documentSnapshot['frequency'],
                            intakeTime: documentSnapshot['intakeTime'],
                            date: (documentSnapshot['date'] as Timestamp)
                                .toDate(),
                            key: documentSnapshot.id,
                          );

                          return AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 50.0,
                              child: FadeInAnimation(
                                child: Container(
                                  margin: const EdgeInsets.only(
                                    left: 10,
                                    right: 15,
                                    top: 25,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Slidable(
                                      key: Key(documentSnapshot.id),
                                      startActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            label: 'Edit',
                                            backgroundColor: Colors.black,
                                            icon: Icons.edit,
                                            onPressed: (context) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MedicationPage(medicationData:
                                                        MedicationData(
                                                      dosageUnit:documentSnapshot['dosageUnit'],
                                                      name: documentSnapshot[
                                                          'name'],
                                                      //type: documentSnapshot[
                                                         // 'type'],
                                                      dosage: documentSnapshot[
                                                          'dosage'],
                                                      amount: documentSnapshot[
                                                          'amount'],
                                                      frequency:
                                                          documentSnapshot[
                                                              'frequency'],
                                                      intakeTime:
                                                          documentSnapshot[
                                                              'intakeTime'],
                                                      date: (documentSnapshot[
                                                                  'date']
                                                              as Timestamp)
                                                          .toDate(),
                                                      key: documentSnapshot.id,
                                                    ),
                                                  ),
                                                ),
                                              ).then((editedMedication) {
                                                if (editedMedication != null) {
                                                  updateMedication(
                                                      editedMedication);
                                                }
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            label: 'Delete',
                                            backgroundColor: Colors.green,
                                            icon: Icons.delete,
                                            onPressed: (context) => {
                                              _deleteMedication(
                                                  documentSnapshot.id)
                                            },
                                          ),
                                        ],
                                      ),
                                      child: Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: ListTile(
                                            title: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${medicationData.name},',
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 3),
                                                      Text(
                                                        medicationData.dosage,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 3),
                                                      Text(
                                                        medicationData
                                                            .dosageUnit,
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            subtitle: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 8.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        'Take ${medicationData.amount}',
                                                      ),
                                                      const SizedBox(width: 3),
                                                      //Text(medicationData.type),
                                                      const SizedBox(width: 3),
                                                      Text(medicationData
                                                          .frequency),
                                                      const SizedBox(width: 3),
                                                      Text(
                                                        'at ${medicationData.intakeTime}',
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  'Date: ${DateFormat.yMd().format(medicationData.date)}',
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (streamSnapshot.hasError) {
                  return const Text('Error');
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MedicationPage(),
              ),
            );
          },
          backgroundColor: Colors.white,
          shape: const CircleBorder(),
          child: const Icon(
            Icons.add,
            color: Colors.red,
            size: 30,
          ),
        ),
      ),
    );
  }
}
