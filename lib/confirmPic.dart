import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'addPracticePic.dart';
import 'package:test_project_db/home.dart';
import 'package:test_project_db/widget/menubar.dart';
import 'package:test_project_db/result.dart';
import 'dart:io';
// import 'package:http/http.dart' as http;



class ConfirmPicPage extends StatefulWidget {
  File img;
  String patternNo;
  int trialNo;

  ConfirmPicPage(this.img, this.patternNo, this.trialNo);

  @override
  State<ConfirmPicPage> createState() => _ConfirmPicPageState();
}

class _ConfirmPicPageState extends State<ConfirmPicPage> {
  // List<Data> data = [];
  String? result_path;
  int score = 0;

  // ----------------- change api url ---------------------//
  final String baseUrl = "http://34.81.100.38:8080";
  // final String baseUrl = "http://10.0.2.2:5000";

  Future<void> _processingImage(File image) async {
    BaseOptions options = new BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 60*1000,
        receiveTimeout: 60*1000
    );
    Dio dio = new Dio(options);

    var fileName = image.path.split('/').last;
    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(image.path, filename: fileName),
      "uid": FirebaseAuth.instance.currentUser?.uid,
      "trial": widget.trialNo.toString(),
      "pattern": widget.patternNo
    });
    //
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),));

    try{
      // print('send data');
      var response = await dio.post("$baseUrl/processing",
          data: formData);
      // print(response);

      // print('call api success');
      final decoded = await json.decode(response.data);
      result_path = decoded['img_url'].toString();
      score = decoded['score'] as int;
      // print(result_path);
      // print(score);
      // print('get response done');

      // print('api success');

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ResultPage(widget.patternNo,widget.trialNo,result_path!,score)));

    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        showDialog(
            context: context,
            builder:(BuildContext context) {
              return AlertDialog(
                title: Text('something went wrong!'),
                content: Text('server error, please try again later'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (_) => Menubar()));
                    },
                  ),
                ],
              );
            });
      }
      print(e);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patternNo, style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),),
        centerTitle: true,
        toolbarHeight: 100,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: Colors.cyan.shade400,

          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Center(
                  child: Text(
                    'Trial: ${widget.trialNo.toString()}',  //db
                    style: TextStyle(
                        color: Colors.cyan.shade400,
                        fontSize: 32,
                        fontWeight: FontWeight.bold
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
                child: Ink.image(
                  image: FileImage(widget.img),
                  height: 400,
                  width: 400,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 30,),

              Container(

                child: TextButton(
                  style: TextButton.styleFrom(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // <-- Radius
                    ),
                    minimumSize: Size(350, 86),
                    backgroundColor: Colors.cyan.shade400,
                  ),
                  onPressed: () {
                    style: TextButton.styleFrom(
                      //foregroundColor: Colors.red,
                      elevation: 4,
                      backgroundColor: Colors.cyan.shade600,
                    );

                    Navigator.canPop(context) ? Navigator.of(context) : null;

                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => AddPracticePicPage(widget.patternNo, widget.trialNo)));

                  },
                  child: Text(
                    'เลือกรูปภาพใหม่',
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 38,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 60,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(

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

                        Navigator.pop(context);
                        Navigator.pushReplacement(
                         context, MaterialPageRoute(builder: (_) => AddPracticePicPage(widget.patternNo, widget.trialNo)));

                      },
                      child: Text(
                        'cancel',
                        style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),

                  Container(

                    child: TextButton(
                      style: TextButton.styleFrom(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // <-- Radius
                        ),
                        minimumSize: Size(260, 86),
                        backgroundColor: Colors.yellow.shade600,
                      ),
                      onPressed: () {
                        _processingImage(widget.img);

                        style: TextButton.styleFrom(
                          //foregroundColor: Colors.red,
                          elevation: 4,
                          backgroundColor: Colors.yellow.shade700,
                        );
                        Navigator.canPop(context) ? Navigator.of(context) : null;
                      },
                      child: Text(
                        'next',
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
