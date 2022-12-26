import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget/background.dart';
import '../widget/menubar.dart';


class TipPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Column(
                  children: <Widget>[

                    Container(
                      height: 70,
                    ),
                    Container(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(0,30,0,30),

                        child: Center(
                          child: Text(
                            'How To Use',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 60,
                                fontWeight: FontWeight.w900,
                                shadows: <Shadow>[
                                  Shadow(
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 4.0,
                                  color: Colors.grey.withOpacity(0.6),
                                ),],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30,0,0,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 16.0,
                          ),
                          Text(
                            '   Choose level of exercise you want to scan',
                            textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30,0,0,0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 16.0,
                          ),
                          Text(
                            '   Use natural light',
                            textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Container(
                        height: 80,
                        width: 200,
                        margin: EdgeInsets.fromLTRB(0,40,0,30),
                        decoration: BoxDecoration(
                          boxShadow: [BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            spreadRadius: 3,
                            blurRadius: 4,
                            offset: Offset(0, 6), // changes position of shadow
                          ),
                          ],
                          color: Colors.yellow.shade600, borderRadius: BorderRadius.all(Radius.elliptical(200, 180)),
                        ),
                        child: Center(
                          child: Text(
                            'TIPS',
                            style: TextStyle(color: Colors.black, fontSize: 45,fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30,0,0,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 16.0,
                          ),
                          Text(
                            '   ติดกระดาษให้ตรงเกือกม้า',
                            textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30,0,0,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 16.0,
                          ),
                          Text(
                            '   ใช้มุมกระจกให้หลากหลาย',
                            textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30,0,0,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 16.0,
                          ),
                          Text(
                            '   Finger rest',
                            textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30,0,0,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 16.0,
                          ),
                          Text(
                            '   จับเครื่องมือให้ถูกต้อง',
                            textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30,0,0,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 16.0,
                          ),
                          Text(
                            '   ติดเทปกาวกับฐานอุปกรณ์ให้แน่น',
                            textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30,0,0,10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            Icons.circle,
                            color: Colors.black,
                            size: 16.0,
                          ),
                          Text(
                            '   ไม่ควรให้ภาพมีแสงและเงากระทบลงบนแบบฝึกทักษะ',
                            textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 30),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 50),

                      child: TextButton(

                        style: TextButton.styleFrom(
                          elevation: 6,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16), // <-- Radius
                          ),
                          minimumSize: Size(270, 80),
                          backgroundColor: Colors.cyan.shade400,
                        ),
                        onPressed: () {
                          style: TextButton.styleFrom(
                            //foregroundColor: Colors.red,
                              elevation: 4,
                              backgroundColor: Colors.cyan.shade600
                          );
                          Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => Menubar()));
                        },
                        child: Text(
                          'START',
                          style: TextStyle(color: Colors.black, fontSize: 40,fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ]

              )
          ),
        ),
      ],

    );

  }
}
