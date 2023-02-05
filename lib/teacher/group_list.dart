import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'color_all.dart';

class GroupListBar extends StatefulWidget {
  GroupListBar({Key? key}) : super(key: key);

  @override
  State<GroupListBar> createState() => _GroupListBarState();
}

class _GroupListBarState extends State<GroupListBar> {
  final db = FirebaseFirestore.instance;

  dynamic groups = [];

  Future<void> groupsList() async {
    print("i am here");
    dynamic newList = [];

    await db.collection("groups").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()}");
        newList.add(doc.data());
      }
    });
    if (groups.length != newList.length)
      setState(() {
        groups = newList;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupsList();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    groupsList();

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * .25,
                decoration: const BoxDecoration(
                  color: kAppBarColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(2, 56, 63, 0.692),
                      offset: Offset(2, 2),
                      blurRadius: 5,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(35),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    icon: Icon(Icons.search),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("List of available groups",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: groups.map<Widget>((e) {
                final groupName = e['groupName'];
                return TextButton(
                    onPressed: () {},
                    child: Text(groupName,
                        style: const TextStyle(
                          fontSize: 18,
                        )));
              }).toList(),
            ),
          ),

          /*Padding(
            padding: EdgeInsets.symmetric(vertical: 100),
            child: Container(
              height: size.height*.10,
              decoration: BoxDecoration( 
                color: Colors.amber,
              ),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back),
                ],
              ),
              
            ),
          ),*/
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kAppBarColor,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      bottomNavigationBar: const BottomNav(),
    );
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // for navigation
      color: kAppBarColor,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: GNav(
          // for using google navigation

          backgroundColor: kAppBarColor,
          color: kAppBarColor,
          activeColor: kAppBarColor,
          tabBackgroundColor: kShadowColor,
          gap: 8, // for creating gap between icon and text
          padding: EdgeInsets.all(5),
          tabs: [
            GButton(
              icon: Icons.arrow_back,
              text: 'Back',
              iconSize: 30,
              onPressed: () {
                print(1);
              },
            ),
          ],
        ),
      ),
    );
  }
}
