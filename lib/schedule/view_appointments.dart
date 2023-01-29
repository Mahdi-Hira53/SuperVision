import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/schedule/schedule_page.dart';
import 'package:login/utility/constant_login.dart';

import 'meeting.dart';

class ViewAppointments extends StatefulWidget {
  const ViewAppointments({super.key});


  @override
  State<ViewAppointments> createState() => _ViewAppointmentsState();
}

class _ViewAppointmentsState extends State<ViewAppointments> {
  List<Meeting> meetings = [];
  int _selectedIndex = -1;
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
            Meeting(eventName, from, to, false, Colors.teal),
          );
        }
        setState(() {
          meetings;
        });
      },
    );
  }

  void deleteData(String EventName) {
    print(EventName);
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('supervisor')
        .doc(EventName);
    documentReference.delete();
    meetings.clear();
    setState(() {
      getData();
    });
  }

  void initState(){
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => CalenderScreen(),));
        }),
        title: Text("All Appointments",),
        backgroundColor: kButtonColor,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: meetings.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
            },
            child: Card(

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    height: 50,
                    child: Text(
                      '${index+1}) ${meetings[index].eventName} ${meetings[index].from} ',
                      style: TextStyle(
                        color: _selectedIndex == index ? kButtonColor : null,
                      ),
                    ),
                  ),
                  IconButton(onPressed: () {


                      deleteData(meetings[_selectedIndex].eventName.toString());


                  }, icon: Icon(Icons.done))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
