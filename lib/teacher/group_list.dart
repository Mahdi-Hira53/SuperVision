

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'color_all.dart';


class GroupListBar extends StatelessWidget {
  const GroupListBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        
        children: [
          Container(
            height: size.height*.25,
            decoration: BoxDecoration(
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
           
            margin: EdgeInsets.all(35),
            
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                icon: Icon(Icons.search),
                border: InputBorder.none,
              ),
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
        onPressed: () {

        },
        backgroundColor: kAppBarColor,
        child: Icon(Icons.add, size: 30,),
      ),

      bottomNavigationBar: BottomNav(),
      

    );
    
  }
}

class BottomNav extends StatelessWidget {
  const BottomNav ({Key? key}) : super(key: key);

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
                onPressed: (){
                  print(1);
                },
              ),
              
            ],
          ),
            
        ),
            
      );
  }
}