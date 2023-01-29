import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:login/schedule/routine_page.dart';
import 'package:login/schedule/view_appointments.dart';
import 'package:login/teacher/home_screen.dart';
import 'package:login/utility/constant_login.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'meeting.dart';
import 'meeting_data_source.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  TextEditingController dateInputController = TextEditingController();
  TextEditingController eventInputController = TextEditingController();
  TextEditingController durationInputController = TextEditingController();
  TextEditingController timeInputController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  int selectedHour = 0;
  int selectedMin = 0;
  final List<Meeting> meetings = [];

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    eventInputController.dispose();
    dateInputController.dispose();
    durationInputController.dispose();
    timeInputController.dispose();
  }

  void setData() {
    final DateTime from =
        selectedDate.add(Duration(hours: selectedHour, minutes: selectedMin));
    final DateTime to =
        from.add(Duration(minutes: int.parse(durationInputController.text)));
    final String eventName = eventInputController.text;

    try {
      final DocumentReference documentReference =
          FirebaseFirestore.instance.collection('supervisor').doc(eventName);
      Map<String, dynamic> schedule = {
        'EventName': eventName,
        'Start': from,
        'End': to,
      };
      documentReference.set(schedule).whenComplete(
        () {
          const SnackBar snackBar =
              SnackBar(content: Text("Successfully Add event"));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
      );
    } on FirebaseException {
      const SnackBar snackBar = SnackBar(
        content: Text(
          "Something Went Wrong!",
          style: TextStyle(color: Colors.red),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  void getData() {
    CollectionReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection('supervisor');

    documentReference.get().then(
      (querySnapshot) {
        for (int i = 0; i < querySnapshot.docs.length; i++) {
          Map<String, dynamic> value = querySnapshot.docs[i].data();

          /// get each documents of collection
          String eventName = value["EventName"];
          DateTime from = value["Start"].toDate();
          DateTime to = value["End"].toDate();
          meetings.add(
            Meeting(eventName, from, to, false, kButtonColor),
          );
        }

        setState(() {
          meetings;
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kButtonColor,
        leading: BackButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
        },),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewAppointments(),
                ),
              );
            },
            icon: const Icon(Icons.schedule),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RoutinePage(),
                ),
              );
            },
            icon: const Icon(Icons.calendar_month),
          )
        ],
        title: const Text("Calender"),
        centerTitle: true,
      ),
      body: SfCalendar(
        todayHighlightColor: kButtonColor,
        allowAppointmentResize: true,
        // allowDragAndDrop: true
        initialSelectedDate: DateTime.now(),
        view: CalendarView.month,
        cellBorderColor: Colors.transparent,
        dataSource: MeetingDataSource(meetings),
        monthViewSettings: const MonthViewSettings(
          showAgenda: true,
          appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kButtonColor,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SimpleDialog(
                  //shape: RoundedRectangleBorder(),
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Event Name',
                        border: OutlineInputBorder(),
                      ),
                      controller: eventInputController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Select Date',
                          border: OutlineInputBorder()),
                      controller: dateInputController,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2050),
                        );

                        if (pickedDate != null &&
                            pickedDate.day >= DateTime.now().day &&
                            pickedDate.month >= DateTime.now().month) {
                          dateInputController.text =
                              '${pickedDate.year}-${pickedDate.month}-${pickedDate.day}';
                          selectedDate = pickedDate;
                        } else {
                          const SnackBar snackBar = SnackBar(
                            content: Text(
                              "Chose Right Date",
                              style: TextStyle(color: Colors.red),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          hintText: 'Select Time',
                          border: OutlineInputBorder()),
                      controller: timeInputController,
                      readOnly: true,
                      onTap: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );
                        if (pickedTime != null) {
                          timeInputController.text = pickedTime.format(context);
                          selectedHour = pickedTime.hour;
                          selectedMin = pickedTime.minute;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: 'Duration in minutes',
                          border: OutlineInputBorder()),
                      controller: durationInputController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kButtonColor,
                      ),
                      onPressed: () {
                        setState(() {
                          setData();
                          meetings.clear();
                          getData();
                        });
                        Navigator.pop(context);
                      },
                      child: const Text("Add"),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: kButtonColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cencel"))
                  ],
                ),
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
