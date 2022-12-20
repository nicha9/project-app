import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project_db/resultModel.dart';

class HistList extends StatelessWidget {
  String? pattern; //collection name -> 'pattern1', 'pattern2'
  String? userID;
  List<Item> _item = [];
  bool descending;

  HistList(this.userID, this.pattern, this.descending);


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //return StreamBuilder(
    return StreamBuilder<List<Item>>(
      stream: readPattern(pattern),
      builder: (context, AsyncSnapshot<List<Item>> snapshot) {
        if (snapshot.hasError) {
          return Text('something went wrong! ${snapshot.error}');
        }
        else if (snapshot.hasData) {
          //_item = snapshot.data!;
          _item = snapshot.data!;
          print(_item);
          //final item = snapshot.data;

          return Container(
              margin: const EdgeInsets.all(10),
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _item.length,
                  itemBuilder: (context, index){
                    final Item patternItem = _item[index];
                    //DocumentSnapshot docs = snapshot.data[index];
                    return Container(
                      //height: 200,
                      width: 280,
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [BoxShadow(
                          blurRadius: 16,
                          offset: Offset(0,3),
                          color: Colors.grey.shade300,
                        )]
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              //height: 250,
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(context: context,
                                      builder: (context) => Center(child: Image.network(
                                        patternItem.result_image,
                                        fit: BoxFit.cover,
                                        // width: size.width,
                                        // height: size.height,
                                      ),)
                                  );

                                  //print('tapping');
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.network(patternItem.result_image, fit: BoxFit.contain,),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Text(
                                    'Trial' + patternItem.trial.toString(),
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.cyan.shade400),
                                  ),SizedBox(height: 10,),
                                  Text(
                                      'date: ' + patternItem.date,
                                    style: TextStyle(fontSize: 20, color: Colors.cyan.shade400),
                                  )
                                ],
                              ),

                              Column(
                                children: [
                                  Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      //shape: BoxShape.circle,
                                      borderRadius: BorderRadius.circular(22),
                                      color: Colors.cyan.shade200,
                                    ),
                                    padding:  const EdgeInsets.symmetric(horizontal: 20),
                                    child: Center(
                                      child: Text(
                                        patternItem.score.toString() + '%',
                                        style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),SizedBox(height: 10,),
                        ],
                      ),
                    );
                  },
                  //children: items!.map(buildUsers).toList()
              ),
          ); //here
        }
        else {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }

  Stream <List<Item>> readPattern(pattern) => FirebaseFirestore.instance
      .collection(pattern).where('id', isEqualTo: userID).orderBy('trial', descending: descending) //filter data
      .snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

}