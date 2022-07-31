import 'package:finger_on_app/constants.dart';
import 'package:finger_on_app/model/competiton.dart';
import 'package:finger_on_app/services/firebase_utils.dart';
import 'package:flutter/material.dart';

class AddCompetition extends StatefulWidget {
  const AddCompetition({Key? key}) : super(key: key);

  @override
  State<AddCompetition> createState() => _AddCompetitionState();
}

class _AddCompetitionState extends State<AddCompetition> {
  TextEditingController nameController = TextEditingController();
  DateTime? startDateTime;
  TimeOfDay? timeOfDay;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Competition'),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text('Enter Competition Name'),
                ),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        startDateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(DateTime.now().year + 10));
                        if (startDateTime != null) {
                          setState(() {});
                        }
                      },
                      child: const Text('Choose Start Date')),
                  startDateTime != null
                      ? Text(
                          'Date: ${startDateTime.toString().substring(0, 10)}')
                      : const Text('No Date Picked')
                ],
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () async {
                        timeOfDay = await showTimePicker(
                          initialTime: TimeOfDay.now(),
                          context: context,
                        );
                        if (startDateTime != null) {
                          setState(() {});
                        }
                      },
                      child: const Text('Choose Start Time')),
                  timeOfDay != null
                      ? Text('Time: ${timeOfDay!.format(context)}')
                      : const Text('No Date Picked')
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                      color: primaryGreen,
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            startDateTime != null &&
                            timeOfDay != null) {
                          DateTime startsDateTime = DateTime(
                                  startDateTime!.year,
                                  startDateTime!.month,
                                  startDateTime!.day,
                                  timeOfDay!.hour,
                                  timeOfDay!.minute)
                              .toUtc();
                          print('Starts time will be');
                          print(startsDateTime);
                          Competition competition = Competition(
                              count: 0,
                              startDateTime:
                                  startsDateTime.millisecondsSinceEpoch,
                              name: nameController.text,
                              winnerWallet: '');
                          FirebaseUtils.addCompetition(competition);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: Colors.white,
                                  dismissDirection: DismissDirection.startToEnd,
                                  padding: EdgeInsets.all(8),
                                  //duration: Duration(seconds: 1),
                                  content: SizedBox(
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        'Competition Added Successfully',
                                        style: TextStyle(color: Colors.green),
                                      ),
                                    ),
                                  )));
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Save')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
