import 'dart:io';
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

  }

  void _getFromGallery() async {
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    _cropImage(pickedFile!.path);

    // print(pickedFile);
  }

  Future <void> _cropImage(pathFile) async {

    CroppedFile? croppedImage = await ImageCropper().cropImage(sourcePath: pathFile);
    if (croppedImage != null) {
      setState(() {
        imageFile = File(croppedImage.path);
      });

      print('patternNo' + widget.patternNo);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ConfirmPicPage(imageFile!, widget.patternNo, widget.trialNo))
      );

    }
  }

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

          ),
        ),
      ),

      body:
      SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[

              Container(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Center(
                  child: Text(
                    'เลือกวิธีเพิ่มรูปภาพแบบฝึก',
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