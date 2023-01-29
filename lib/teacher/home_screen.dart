import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intl/intl.dart';
import 'package:login/utility/constant_login.dart';
import 'package:login/utility/reusable_button.dart';

import '../schedule/schedule_page.dart';
import 'color_all.dart';
import 'group_list.dart';
//import 'package:bangla_utilities/bangla_utilities.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    //String bengaliDate = DateFormat.yMMMMd("bn_BD").format(DateTime.now());

    /*var date = BanglaUtility.getBanglaDate();
    var month = BanglaUtility.getBanglaMonthName();
    var week = BanglaUtility.getBanglaWeekday();
    var year = BanglaUtility.getBanglaSeason();*/

    return Scaffold(
      bottomNavigationBar: const BottomNavigationBar(),
      body: Stack(
        children: [
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
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
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Hello,\nGood Morning",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                          height: 52,
                          width: 52,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 2, 53, 62),
                            shape: BoxShape.circle,
                          ),
                          child: Expanded(
                            child: IconButton(
                              icon: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // Here we write a code for notification
                                print(3);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        //DateFormat("'EEEE, yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
                        DateFormat('EEEE, dd MMM yyyy').format(DateTime.now()),

                        //DateFormat.yMMMd().format(DateTime.now()),
                        style: const TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),

                      /*Text(
                        date,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          color: Colors.white,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            week,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 10,),

                          Text(
                            month!,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 10,),

                          Text(
                            year!,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 15,
                              color: Colors.white,
                              //fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(50),
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: [
                        GroupHome(),
                        ScheduleHome(),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavigationBar extends StatelessWidget {
  const BottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // for navigation
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: GNav(
          // for using google navigation

          backgroundColor: Colors.white,
          color: kAppBarColor,
          activeColor: kAppBarColor,
          tabBackgroundColor: kTabBackgroundColor,
          gap: 8,
          // for creating gap between icon and text
          padding: EdgeInsets.all(5),
          tabs: [
            GButton(
              icon: Icons.logout_rounded,
              text: 'Log Out',
              iconSize: 30,
              onPressed: () async {
                FirebaseAuth _auth = FirebaseAuth.instance;
                await _auth.signOut();
              },
            ),
            GButton(
              icon: Icons.account_box,
              text: 'Profile',
              iconSize: 30,
              onPressed: () {

              },
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
              iconSize: 30,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class GroupHome extends StatelessWidget {
  const GroupHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Here we call group button
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const GroupListBar()),
              );
              //print(1);
            },
            child: Column(
              children: [
                //SvgPicture.asset("assets/icons/group.svg"),
                //SvgPicture.asset("images/group.svg"),
                Padding(
                  padding: EdgeInsets.all(35),
                ),
                Icon(
                  Icons.group,
                  color: kAppBarColor,
                  size: 50,
                ),

                Text(
                  "Group",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20,
                    color: kAppBarColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScheduleHome extends StatelessWidget {
  const ScheduleHome({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(13),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Here we call Schedule button
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => (CalenderScreen()),
                ),
              );
            },
            child: Column(
              children: [
                //SvgPicture.asset("assets/icons/group.svg"),
                //SvgPicture.asset("images/group.svg"),
                Padding(
                  padding: EdgeInsets.all(35),
                ),
                Icon(
                  Icons.schedule,
                  color: kAppBarColor,
                  size: 50,
                ),

                Text(
                  "Schedule",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 20,
                    color: kAppBarColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
