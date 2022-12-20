
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_project_db/home.dart';
import 'package:test_project_db/menubar.dart';

import 'addPracticePic.dart';

class ResultPage extends StatefulWidget{

  String pathFile;
  String patternNo;
  int trialNo;
  int errScore;

  ResultPage(this.patternNo, this.trialNo, this.pathFile, this.errScore);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  double overallErr = 0;
  var _avId;
  var _avTrial;
  var _avScore;
  var _score1;
  var _score2;
  var _xscore;
  // num _score = 0;
  var user = FirebaseAuth.instance.currentUser;

  Future<void> getUserData() async {
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users').doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (userDoc == null) {
      return;
    }
    else {
      setState(() {
        _score1 = userDoc.get('pt1_score');
        _score2 = userDoc.get('pt2_score');
        _xscore = userDoc.get('x_score');
      });
    }
  }

  Future<void> getAverageData() async {
    try {
      final DocumentSnapshot aveDoc = await FirebaseFirestore.instance
          .collection('average').doc('${widget.patternNo}_${widget.trialNo}').get();

      if (aveDoc == null) {
        return;
      }
      else {
        setState(() {
          _avId = aveDoc.get('id');
          _avTrial = aveDoc.get('trial');
          _avScore = aveDoc.get('score');
        });
      }
    } catch (e){
      print(e);
    }
  }


  @override
  void initState() {

    getAverageData();
    getUserData();
    super.initState();
  }

  _getOverallError() {
    // _score = int.parse(widget.errScore);
    overallErr = ((widget.errScore/133)*100.0);
    return overallErr.floor();
  }

  _calculate(num x, num y){
    int total = ((x + y)/2).floor();
    return total;
  }


  _saveData() async{
    DateTime today = DateTime.now();
    String dateStr = "${today.day}/${today.month}/${today.year}";
    num err = _getOverallError();
    print(dateStr);
    //create new pattern.. data
    try{
      user = FirebaseAuth.instance.currentUser;
      print('update data to firestore');
      CollectionReference aveRef = FirebaseFirestore.instance.collection('average');
      CollectionReference uRef = FirebaseFirestore.instance.collection('users');
      // FirebaseFirestore.instance.collection('users').doc(user!.uid).set(data, SetOptions(merge: true));
      CollectionReference ref = FirebaseFirestore.instance.collection(widget.patternNo);
      await ref.doc().set({
        'id': user!.uid,
        'result_image': widget.pathFile,
        'score': _getOverallError(),
        'trial': widget.trialNo,
        'date' : dateStr,
      });

      print(widget.patternNo);
      //update pattern trial
      if(widget.patternNo == 'pattern1'){
        print('update pattern'+(widget.trialNo+1).toString());
        // await aveRef.doc('${widget.patternNo}_${widget.trialNo}').update({'score': ((_avScore + widget.errScore)/2).floor()});
        await uRef.doc(user!.uid).update({'trial_pattern1': widget.trialNo+1,});
        // await uRef.doc(user?.uid).update({'pt1_score': widget.errScore+widget._score});
        await uRef.doc(user!.uid).update({'pt1_score': ((_score1 + err)/2).floor()});
        // await uRef.doc(user!.uid).update({'pt1_score': ((_score1 + widget.errScore)/2).floor()});
      }else{
        print('update pattern'+(widget.trialNo+1).toString());
        print('update score '+ ((_score2 + widget.errScore)/2).toString());
        await uRef.doc(user!.uid).update({'trial_pattern2': widget.trialNo+1,});
        // await uRef.doc(user?.uid).update({'pt2_score': widget.errScore+widget._score});
        await uRef.doc(user!.uid).update({'pt2_score': ((_score2 + err)/2).floor()});
        // await uRef.doc(user!.uid).update({'pt2_score': ((_score2 + widget.errScore)/2).floor()});
      }
      //update x_score
      print('doc: ${widget.patternNo}_${widget.trialNo-1}');
      //update
      try{
        await aveRef.doc('${widget.patternNo}_${widget.trialNo-1}').update({'score': _calculate(_avScore, err)});
      } catch (e){
        CollectionReference ref = FirebaseFirestore.instance.collection('average');
        ref.doc('${widget.patternNo}_${widget.trialNo}').set({
          'id': widget.patternNo,
          'trial': widget.trialNo,
          'score': err,
        });
      }

      print('update xscore ${_calculate(_xscore, err)}');
      if (_xscore == 0) {
        await uRef.doc(user!.uid).update({'x_score': err});
      } else {
        await uRef.doc(user!.uid).update({'x_score': _calculate(_xscore, err)});
      }

      //((_xscore + err)/2).floor(),

      showDialog(
          context: context,
          builder:(BuildContext context) {
            return AlertDialog(
              title: Text('SAVE'),
              content: Text(widget.patternNo + ' ' + widget.trialNo.toString() + 'was saved!!'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    //Navigator.canPop(context); //close popup
                    // Navigator.canPop(context) ? Navigator.of(context) : null;

                    Navigator.canPop(context) ? Navigator.of(context) : null;
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => Menubar()));
                  },
                ),
              ],
            );
          });

    } catch(e){
      print(e);
    }
  }
  //localhost
  // final String baseUrl = "http://10.0.2.2:5000";
  final String baseUrl = "http://34.81.100.38:8080";
  Future<void> _clear() async {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 10*1000, // 60 seconds
        receiveTimeout: 10*1000 // 60 seconds
    );
    Dio dio = new Dio(options);

    // final Dio dio = Dio();

    FormData formData = FormData.fromMap({
      "path": widget.pathFile,
    });
    //
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),));

    try{
      var response = await dio.delete("$baseUrl/processing/cancel",
          data: formData);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => Menubar())
      );

    } on DioError catch (e) {
      print(e);
    }

  }

  // _updateData(int pat1, int pat2) async {
  //   CollectionReference ref = FirebaseFirestore.instance.collection('users');
  //   await ref.doc(user?.uid).update({
  //     'trial_pattern1': widget.trialNo+pat1,
  //     'trial_pattern2': widget.trialNo+pat2,
  //     // 'x_score': ,
  //   }
  // );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Result', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),),
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
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Center(
                  child: Text(
                    'Summary of exercise',
                    style: TextStyle(
                        color: Colors.cyan.shade400,
                        fontSize: 40,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ),

              //แสดง image
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(color: Colors.cyan.shade300, width: 3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GestureDetector(
                  onTap: (){
                    print('tap');
                    showDialog(context: context,
                        builder: (context) => Center(child: Image.network(
                      widget.pathFile,
                      fit: BoxFit.cover,
                    ),));
                  },

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(widget.pathFile, height: 400, width: 400,fit: BoxFit.cover,),
                  ),
                ),

              ),
              SizedBox(height: 20,),
              Container(
                height: 65,
                child: Text(
                  'Trial '+widget.trialNo.toString(),
                  style: TextStyle(
                      color: Colors.cyan.shade400,
                      fontSize: 30,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Container(
                child: Text(
                  'Overall Error %   =   ' + _getOverallError().toString() + ' %',
                  style: TextStyle(
                      color: Colors.cyan.shade400,
                      fontSize: 36,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              SizedBox(height: 50,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    //alignment: Alignment.center,
                    //padding: EdgeInsets.fromLTRB(50, 40, 30, 40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // <-- Radius
                        ),
                        minimumSize: Size(260, 86),
                        backgroundColor: Colors.grey,
                      ),
                      onPressed: () {
                        style: TextButton.styleFrom(
                          //foregroundColor: Colors.red,
                          elevation: 4,
                          backgroundColor: Colors.grey.shade600,
                        );
                        showDialog(
                            context: context,
                            builder:(BuildContext context) {
                              return AlertDialog(
                                title: Text('Are you sure?'),
                                content: Text('Are you sure you want to delete the result.'),
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
                                      _clear();
                                    },
                                  ),
                                ],
                              );
                            });
                        // Navigator.canPop(context) ? Navigator.of(context) : null;
                        // Navigator.pushReplacement(
                        //     context, MaterialPageRoute(builder: (_) => Menubar()));

                      },
                      child: Text(
                        'cancel',
                        style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  Container(
                    //padding: EdgeInsets.fromLTRB(50, 40, 30, 40),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // <-- Radius
                        ),
                        minimumSize: Size(260, 86),
                        backgroundColor: Colors.cyan.shade400,
                      ),
                      onPressed: () {
                        //dialog save success

                        style: TextButton.styleFrom(
                          //foregroundColor: Colors.red,
                          elevation: 4,
                          backgroundColor: Colors.cyan.shade600,
                        );
                        //แก้, update db ->? trial number, save score
                        _saveData();
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (_) => ResultPage(widget.patternNo,widget.trialNo)));
                      },
                      child: Text(
                        'save',
                        style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}