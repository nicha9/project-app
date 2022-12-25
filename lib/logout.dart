import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project_db/login.dart';

import 'widget/menubar.dart';

class UserPage extends StatefulWidget {
  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final user = FirebaseAuth.instance.currentUser;
  String? _name;
  String? _profileImg;

  void getUserData() async {
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
        print(_profileImg);
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
      //backgroundColor: Colors.cyan.shade400,

      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.canPop(context) ? Navigator.of(context) : null;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Menubar()));
          },
        ),
        backgroundColor: Colors.cyan.shade400,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              //แถบด้านบน
              padding: EdgeInsets.only(top: 40, bottom: 40) ,
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

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black12, spreadRadius: 2)],
                      shape: BoxShape.circle,
                    ),
                    child: CircleAvatar(
                      minRadius: 100,
                      backgroundImage: NetworkImage(_profileImg ?? ''),
                    ),
                  ),
                  Text(
                    _name ?? '' , //db
                    style: TextStyle(
                        color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    FirebaseAuth.instance.currentUser!.email!, //db
                    style: TextStyle(
                        color: Colors.white70, fontSize: 30),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),

            //logout button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300,60),
                backgroundColor: Colors.cyan.shade400,
                elevation: 6,
                shadowColor: Colors.grey,
              ),
                onPressed: () => {
                  showDialog(
                      context: context,
                      builder:(BuildContext context) {
                        return AlertDialog(
                          title: Text('Are you sure?'),
                          content: Text('Are you sure you want to sign out you account?'),
                          actions: [
                            TextButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => Login())
                                );
                              },
                            ),
                          ],
                        );
                      }),
                },
                icon: Icon(Icons.arrow_back, size: 30,),
                label: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 30),
                )
            ),
          ],
        ),
      ),
    );
  }
}