import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project_db/overallGraph.dart';

class TeacherGraph extends StatefulWidget{
  @override
  State<TeacherGraph> createState() => _TeacherGraphState();
}

class _TeacherGraphState extends State<TeacherGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Performance', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),),
        centerTitle: false,
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.cyan.shade400,
            /*gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.teal.shade200, Colors.cyan.shade400],
              //colors: [Colors.cyan.shade400, Colors.deepPurple.shade600], //blue700, indigo
            ),*/
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Container(
              child: Center(
                child: Text(
                  'Overall Perfomance',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.cyan.shade400),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Text(
                'Pattern 1',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.cyan.shade400),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OverallGraph("pattern1"),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Text(
                'Pattern 2',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: Colors.cyan.shade400),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            OverallGraph("pattern2"),
          ],
        ),
      ),

    );
  }
}