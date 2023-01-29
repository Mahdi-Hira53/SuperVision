import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:login/utility/constant_login.dart';
import 'package:intl/intl.dart';

import 'color_all.dart';
import 'home_screen.dart';


class HomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("en", "US"),
        Locale("bn", "BD"),
      ],
      debugShowCheckedModeBanner: false,
      title: 'LeadTeam',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),

      ),
      home: const HomeScreen(),
    );
  /**
  int today = int.parse(DateFormat('dd').format(DateTime.now()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF104D5B),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, Welcome",
              style: GoogleFonts.firaCode(
                textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ),
            Text(
              DateFormat("EEEEE, dd MMMM yyyy").format(DateTime.now()),
              style: GoogleFonts.firaCode(
                textStyle:
                    TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
          
          ],
        ),
        toolbarHeight: 200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  "Group",
                  style: GoogleFonts.firaCode(
                    textStyle: TextStyle(fontSize: 18, color: kButtonColor),
                  ),
                ),
                icon: Icon(
                  Icons.group,
                  size: 30,
                  color: kButtonColor,
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.grey.shade300,
                  maximumSize: Size(180, 150),
                  minimumSize: Size(180, 150),
                ),
              ),
              SizedBox(
                width: 30,
              ),
              ElevatedButton.icon(
                onPressed: () {},
                label: Text(
                  "Schedule",
                  style: GoogleFonts.firaCode(
                    textStyle: TextStyle(fontSize: 18, color: kButtonColor),
                  ),
                ),
                icon: Icon(
                  Icons.schedule,
                  size: 30,
                  color: kButtonColor,
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.grey.shade300,
                  maximumSize: Size(180, 150),
                  minimumSize: Size(180, 150),
                ),
              )
            ],
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            color: Colors.grey.shade300,
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                iconColor: kButtonColor,
                title: Text("Create Groupe"),
                onTap: () {},
                leading: Icon(Icons.create_new_folder),
              ),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
            color: Colors.grey.shade300,
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListTile(
                iconColor: kButtonColor,
                title: Text("Create Schedule"),
                onTap: () {},
                leading: Icon(Icons.create),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(
          backgroundColor: kButtonColor,
          icon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.home,
            ),
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.chat,
            ),
          ),
          label: "Chat",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
            ),
          ),
          label: "Notification",
        ),
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.man,
            ),
          ),
          label: "Profile",
        )
      ]),
    );*/
  }
}
