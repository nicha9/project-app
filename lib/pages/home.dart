import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'addPracticePic.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //db
  String? _name;
  String? _profileImg;
  var _trial1;
  var _trial2;


  //create pattern collection in firestore
  Future _createPattern() async {
    CollectionReference patternRef = FirebaseFirestore.instance.collection('pattern');
    CollectionReference userRef = FirebaseFirestore.instance.collection('users');

  }

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
        _trial1 = userDoc.get('trial_pattern1');
        _trial2 = userDoc.get('trial_pattern2');
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
            children: <Widget>[
              //container for user profile
              Container(
                padding: const EdgeInsets.fromLTRB(60, 80, 60, 50),
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
                              'Hi! ${_name ?? ''}', //db
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
                height: 30,
              ),

              //title
              Container(
                child: Center(
                  child: Text(
                    'เลือกรูปแบบแบบฝึกหัดที่ต้องการประเมิน',
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.cyan.shade400,
                          fontSize: 32,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),

              //pattern choice
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Material(  //contain img+name of pattern

                        elevation: 0,
                        borderRadius: BorderRadius.circular(10),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          onTap: () { //pattern1
                            //db
                            _createPattern();
                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) => AddPracticePicPage("pattern1", _trial1)));
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.cyan.shade300, width: 3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Ink.image(
                                  image: const AssetImage("images/pattern1.jpg"),
                                  height: 156*1.5,
                                  width: 172*1.5,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'รูปแบบที่ 1',
                                style: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                      color: Colors.cyan.shade400,
                                      fontSize: 23,
                                      //fontWeight: FontWeight.w500
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    Container(
                      child: Material(  //contain img+name of pattern
                        elevation: 0,
                        borderRadius: BorderRadius.circular(16),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: InkWell(
                          onTap: () {
                            //db
                            _createPattern();

                            Navigator.push(
                                context, MaterialPageRoute(builder: (_) => AddPracticePicPage("pattern2", _trial2)));
                          },
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.cyan.shade300, width: 3),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Ink.image(
                                  image: const AssetImage("images/pattern4.jpg"),
                                  height: 156*1.5,
                                  width: 172*1.5,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'รูปแบบที่ 2',
                                style: GoogleFonts.prompt(
                                  textStyle: TextStyle(
                                    color: Colors.cyan.shade400,
                                    fontSize: 23,
                                    //fontWeight: FontWeight.w500
                                  ),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              //choice new row
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Material(  //contain img+name of pattern
                            elevation: 0,
                            borderRadius: BorderRadius.circular(10),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              //onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,  //enable->transparent
                                      border: Border.all(color: Colors.cyan.shade300, width: 3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    //overlay lock icon for disable pattern
                                    child: Ink.image(
                                      image: const AssetImage("images/pattern3.jpg"),
                                      height: 156*1.5,
                                      width: 172*1.5,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'รูปแบบที่ 3',
                                    style: GoogleFonts.prompt(
                                      textStyle: TextStyle(
                                        color: Colors.cyan.shade400,
                                        fontSize: 23,
                                        //fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Icon(Icons.lock, color: Colors.black26, size: 40,)
                        ],
                      ),
                    ),
                    Container(
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Material(  //contain img+name of pattern
                            elevation: 0,
                            borderRadius: BorderRadius.circular(10),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: InkWell(
                              //onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white70,  //enable->transparent
                                      border: Border.all(color: Colors.cyan.shade300, width: 3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    //overlay lock icon for disable pattern
                                    child: Ink.image(
                                      image: const AssetImage("images/pattern2.jpg"),
                                      height: 156*1.5,
                                      width: 172*1.5,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    'รูปแบบที่ 4',
                                    style: GoogleFonts.prompt(
                                      textStyle: TextStyle(
                                        color: Colors.cyan.shade400,
                                        fontSize: 23,
                                        //fontWeight: FontWeight.w500
                                      ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Icon(Icons.lock, color: Colors.black26, size: 40,)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      );
    }

  }