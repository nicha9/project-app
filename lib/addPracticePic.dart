import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'confirmPic.dart';



class AddPracticePicPage extends StatefulWidget {
  String patternNo;
  var trialNo;

  AddPracticePicPage(this.patternNo, this.trialNo);

  @override
  State<AddPracticePicPage> createState() => _AddPracticePicPageState();
}

class _AddPracticePicPageState extends State<AddPracticePicPage> {


  File? imageFile;
  String?  imageUrl;

  void _getFromCamera() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    _cropImage(pickedFile!.path);
    //Navigator.pop(context);
  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);
    //Navigator.pop(context);
    print(pickedFile);
  }

  Future <void> _cropImage(pathFile) async {

    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: pathFile);
    if (croppedImage != null) {
      // print('is this using?');
      setState(() {
        imageFile = File(croppedImage.path);
      });
      // print('save img');
      //_saveTmpPic();

      //Navigator.canPop(context) ? Navigator.of(context) : null;
      print('patternNo' + widget.patternNo);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ConfirmPicPage(imageFile!, widget.patternNo, widget.trialNo))
      );

    }
  }

  /*Future<void> _saveTmpPic() async {

    try {
      final User? user = FirebaseAuth.instance.currentUser;
      //final _uid = user!.uid;
      final ref = FirebaseStorage.instance.ref().child('tmpImg').child('${user!.uid}.jpg');
      await ref.putFile(imageFile!);
      
      imageUrl = await ref.getDownloadURL();
      final data = {"tempImg": imageUrl};
      //db.collection("cities").doc("BJ").set(data, SetOptions(merge: true));
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set(data, SetOptions(merge: true));

      Navigator.canPop(context) ? Navigator.of(context) : null;

      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ConfirmPicPage(imageFile!, widget.patternNo))
      );

    } catch (e) {
      setState(() {});
      showDialog(
          context: context,
          builder:(BuildContext context) {
            return AlertDialog(
              title: Text('error'),
              content: Text('$e'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    //close dialog
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
    }

  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.patternNo, style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),),
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

      body:
      SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              // Container(height: 5,),
              //image box
              Container(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Center(
                  child: Text(
                    'เลือกวิธีเพิ่มรูปภาพแบบฝึก',
                    style: GoogleFonts.prompt(
                      textStyle: TextStyle(
                        /*shadows: <Shadow>[
                          Shadow(
                            offset: Offset(3.0, 3.0),
                            blurRadius: 2.0,
                            color: Colors.grey.withOpacity(0.3),
                          ),],*/
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
                      //foregroundColor: Colors.red,
                      elevation: 4,
                      backgroundColor: Colors.cyan.shade600,
                    );
                    _getFromCamera();  //camera api

                    //Navigator.push(
                    //context, MaterialPageRoute(builder: (_) => Menubar()));
                  },
                  child: Text(
                    'CAMERA',
                    style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.bold),
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
                      //foregroundColor: Colors.red,
                      elevation: 4,
                      backgroundColor: Colors.cyan.shade600,
                    );
                    _getFromGallery(); //gallery api
                    //Navigator.push(
                    //context, MaterialPageRoute(builder: (_) => Menubar()));
                  },
                  child: Text(
                    'GALLERY',
                    style: TextStyle(color: Colors.white, fontSize: 40,fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}