import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project_db/pages/studentList.dart';
import 'package:test_project_db/pages/teacherGraph.dart';
import 'login.dart';


class TeacherHomePage extends StatefulWidget {
  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  String? _name;

  String? _profileImg;

  Future<void> getUserData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userDoc == null) {
      return;
    }
    else {
      setState(() {
        _name = userDoc.get('name');
        _profileImg = userDoc.get('profileImg');
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(60, 90, 60, 50),
              //height: size.height*0.3,
              decoration: BoxDecoration(
                color: Colors.cyan.shade400,

                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(36),
                    bottomLeft: Radius.circular(36)
                ),
                boxShadow: [BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 6,
                  blurRadius: 7,
                  offset: Offset(0, 5), // changes position of shadow
                ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Hi! $_name', //db
                            style: TextStyle(

                                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser!.email!, //db
                          style: TextStyle(
                              color: Colors.white70, fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    minRadius: 55,
                    backgroundImage: NetworkImage(_profileImg ?? ''),

                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),

            Container(
              margin: EdgeInsets.only(top: 30),
              child: TextButton(
                style: TextButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // <-- Radius
                  ),
                  minimumSize: Size(500, 100),
                  backgroundColor: Colors.cyan.shade400,
                ),
                onPressed: () {
                  style: TextButton.styleFrom(
                      elevation: 4,
                      backgroundColor: Colors.cyan.shade600,
                  );
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => StudentListPage()));
                },
                child: Text(
                  'Individual Performance',
                  style: TextStyle(color: Colors.white, fontSize: 40),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 60),

              child: TextButton(

                style: TextButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // <-- Radius
                  ),
                  minimumSize: Size(500, 100),
                  backgroundColor: Colors.cyan.shade400,
                ),
                onPressed: () {
                  style: TextButton.styleFrom(
                    elevation: 4,
                    backgroundColor: Colors.cyan.shade600,
                  );
                  Navigator.push(
                  context, MaterialPageRoute(builder: (_) => TeacherGraph()));
                },
                child: Text(
                  'Class Performance',
                  style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.bold),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 100),

              child: TextButton(

                style: TextButton.styleFrom(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // <-- Radius
                  ),
                  minimumSize: Size(350, 80),
                  backgroundColor: Colors.grey.shade400,
                ),
                onPressed: () {
                  style: TextButton.styleFrom(
                    //foregroundColor: Colors.red,
                    elevation: 4,
                    backgroundColor: Colors.grey.shade600,
                  );
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Login())
                  );
                },
                child: Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white, fontSize: 36,fontWeight: FontWeight.bold),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
