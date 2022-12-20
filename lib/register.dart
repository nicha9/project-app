import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'main.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  _RegisterPageState();

  final formKey = GlobalKey<FormState>(); //test1
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  //db
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerName = TextEditingController();
  //final _controllerRole = TextEditingController();

  @override
  void dispose(){
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerName.dispose();
    //_controllerRole.dispose();
    super.dispose();
  }

  String msg = "";
  static const items = <String>["Student", "Teacher"];
  List<DropdownMenuItem<String>> _myitems = items
      .map((e) => DropdownMenuItem(
        value: e,
        child: Text(e),
  ))
      .toList();
  String valueItem = "Student";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up', style: TextStyle(fontSize: 60, fontWeight: FontWeight.w300),),
        centerTitle: true,
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
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: Container(
                    width: 200,
                    height: 1,
                  ),
                ),
              ),
              Container(
                width: 600,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: RequiredValidator(errorText: 'Please input your name'),
                  //controller: _username,
                  controller: _controllerName, //db
                  decoration: InputDecoration(
                    labelText: 'Name : ',
                    hintText: 'Enter your name',
                  ),
                  style: TextStyle(
                      fontSize: 30.0,
                      height: 2.0,
                      color: Colors.black
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 600,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Please input your email.'),
                    EmailValidator(errorText: 'Invalid email address. Please try again.')
                  ]),
                  keyboardType: TextInputType.emailAddress,
                  //controller: _password,
                  controller: _controllerEmail, //db
                  decoration: InputDecoration(
                    labelText: 'Email : ',
                    hintText: 'Enter your email',
                  ),
                  style: TextStyle(
                      fontSize: 30.0,
                      height: 2.0,
                      color: Colors.black
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                width: 600,
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Please setting your password.'),
                    MinLengthValidator(6, errorText: 'Password must be at least 6'),
                  ]),
                  controller: _controllerPassword, //db
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password : ',
                    hintText: 'Enter your password',

                  ),
                  style: TextStyle(
                      fontSize: 30.0,
                      height: 2.0,
                      color: Colors.black
                  ),
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: 600,
                child: Text('Choose Your Role:',
                  style: TextStyle(
                      fontSize: 30.0,
                      height: 2.0,
                      color: Colors.black54
                  ),),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 600,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1.5,color: Colors.cyan.shade400),
                      borderRadius: BorderRadius.circular(20.0),
                   ),
                  child: ListTile(

                      title: DropdownButton(
                        style: TextStyle(
                            fontSize: 30.0,
                            height: 1.8,
                            color: Colors.black
                        ),

                        isExpanded: true,
                        isDense: true,
                        underline: SizedBox.fromSize(),

                        iconSize: 55,
                        iconEnabledColor: Colors.cyan.shade400,
                        items: _myitems,
                        value: valueItem,
                        onChanged: (e) {
                          setState(() {
                            valueItem = e!;
                          });
                        },
                      )
                  )
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                //padding: EdgeInsets.only(top: 90),
                height: 70,
                width: 350,
                decoration: BoxDecoration(
                    color:  Colors.cyan.shade400, borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    //insertApi();
                    //print(_name);
                    //print(_password);

                    //db C
                    // final user = User(
                    //   name: controllerName.text,
                    //   email: controllerEmail.text,
                    //   password: controllerPassword.text,
                    //   role: controllerRole.text
                    // );

                    _signUp();

                    //กลับไปหน้า login
                    // Navigator.of(context).push( //ไปหน้า register
                    //     MaterialPageRoute(builder: (context) => Login())
                    // );

                  },
                  child: Text(
                    // REGISTER
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
              ),
              SizedBox(
                height: 130,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    //loading
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator(),));

    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      );

      /*await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _controllerEmail.text.trim(),
        password: _controllerPassword.text.trim(),
      ).then((value) => {

      }).catchError((e){});*/
      
      var user = FirebaseAuth.instance.currentUser;

      //create user data to firestore
      CollectionReference ref = FirebaseFirestore.instance.collection('users');
      ref.doc(user!.uid).set({
        'id': user.uid,
        'name': _controllerName.text,
        'email': _controllerEmail.text,
        'password': _controllerPassword.text,
        'role': valueItem,
        'profileImg': "https://images.unsplash.com/photo-1574158622682-e40e69881006?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=580&q=80", //default profile image
      });

      if(valueItem == 'Student') {
        print('its student');
        ref.doc(user.uid).set({'pt2_score': 0 }, SetOptions(merge: true));
        ref.doc(user.uid).set({'pt1_score': 0 }, SetOptions(merge: true));
        ref.doc(user.uid).set({'x_score': 0 }, SetOptions(merge: true));
        ref.doc(user.uid).set({'trial_pattern1': 1 }, SetOptions(merge: true));
        ref.doc(user.uid).set({'trial_pattern2': 1 }, SetOptions(merge: true));
        // CollectionReference patRef1 = FirebaseFirestore.instance.collection('pattern1');
        // CollectionReference patRef2 = FirebaseFirestore.instance.collection('pattern2');
      }

      // FirebaseFirestore.instance.collection('users').doc(_uid).set({
      //   'id': _uid,
      //   'name': _controllerName.text,
      //   'email': _controllerEmail.text,
      //   'password': _controllerPassword.text,
      //   'role': valueItem
      //   //'profileImage': imageURL,
      //   //'time': Timpstamp.naw()
      // });

      //Navigator.canPop(context) ? Navigator.of(context) : null;

      showDialog(
          context: context,
          builder:(BuildContext context) {
            return AlertDialog(
              title: Text('success'),
              content: Text('create your account is succesfully'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.pop(context); //close popup
                    // Navigator.canPop(context) ? Navigator.of(context) : null;

                    Navigator.of(context).pushReplacement( //register สำเร็จแล้วเข้าแอปได้เลย
                        MaterialPageRoute(builder: (context) => Login())
                    );
                  },
                ),
              ],
            );
          });
      
    } on FirebaseAuthException catch (e) {
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
                    //Navigator.canPop(context) ? Navigator.of(context) : null;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    //Navigator.canPop(context) ? Navigator.of(context) : null;
                  },
                ),
              ],
            );
          });
    }
    //return const CircularProgressIndicator();
  }


}

//db C
// class User {
//   String id;
//   final String email;
//   final String password;
//   final String name;
//   final String role;
//
//   User({
//     this.id = '',
//     required this.password,
//     required this.email,
//     required this.name,
//     required this.role,
//   });
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'username': email,
//     'password': password,
//     'name': name,
//     'role': role
//   };
// } //class user
