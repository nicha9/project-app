import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project_db/widget/histList.dart';

import '../widget/menubar.dart';


class SubmitPage extends StatelessWidget {
  final userID = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trial', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),),
        centerTitle: false,
        toolbarHeight: 100,
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.canPop(context) ? Navigator.of(context) : null;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Menubar()));
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.cyan.shade400,
          ),
        ),
      ),

      // pattern1 result list
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  const Text(
                    'Pattern 1',
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w500, color: Colors.cyan),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 370,
              //child: Flexible (
                child: HistList(userID,'pattern1', true),
              //)
            ),

            const SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  const Text(
                    'Pattern 2',
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w500, color: Colors.cyan),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 350,
              child: HistList(userID, 'pattern2', true),
            ),

          ],
        ),
      )
    );

  }

}
