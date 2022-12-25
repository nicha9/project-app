
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project_db/widget/histList.dart';
import 'package:test_project_db/studentDetail.dart';

//json 'Users' model
import 'model/userModel.dart';

class StudentListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),),
        //centerTitle: true,
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.cyan.shade400,

          ),
        ),
      ),

      body: StreamBuilder<List<Users>>(
        stream: readUsers(),
        builder: (context, AsyncSnapshot<List<Users>> snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          }
          else if (snapshot.hasData) {
            final _users = snapshot.data;
             return Container(
               margin: EdgeInsets.all(15),

               child: ListView.builder(
                 itemCount: _users?.length,
                   itemBuilder: (context,index){
                     final Users users = _users![index];
                     return Container(
                       child: Card(

                         child: ListTile(
                           leading: CircleAvatar(
                             maxRadius: 40,
                             backgroundColor: Colors.amber.shade400,
                             child: Text(
                               users.x_score.toString(),
                               style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
                             ),
                           ),

                           contentPadding: EdgeInsets.all(10),
                           title: Text(users.name, style: TextStyle(fontSize: 27),),
                           subtitle: Text((users.trial_pattern1+users.trial_pattern2-2).toString()+' trial',style: TextStyle(fontSize: 18),),
                           trailing: Icon(Icons.arrow_forward_ios),
                           onTap: (){
                             //print('ontap');

                             Navigator.push(
                                 context, MaterialPageRoute(builder: (_) => StudentDetail(users.id, users.name))
                             );
                           },
                         ),
                       ),
                     );
                   },
               ),
             );
          }
          else {
            return Center(child: CircularProgressIndicator(),);
          }
        },
      ),

    );
  }

  Stream <List<Users>> readUsers() => FirebaseFirestore.instance
      .collection('users').where('role', isEqualTo: 'Student').orderBy('x_score', descending: true) //filter data
      .snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());

}
