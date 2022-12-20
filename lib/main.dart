import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project_db/forgotpassword.dart';
//import 'package:package_info_plus/package_info_plus.dart';

import 'teacherHome.dart';
import 'register.dart';
import 'tip.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //runApp(const MyApp());
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //scaffoldMessengerKey: Utils.mess,
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

/*class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null) {

            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("users").doc(snapshot.data.uid).snapshots() ,
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot){
                if(snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc?.data();
                  if(user!['role'] == 'admin') {
                    return TeacherHomePage();
                  }else{
                    return TipPage();
                  }
                }else{
                  return Material(
                    child: Center(child: CircularProgressIndicator(),),
                  );
                }
              },
            );
          }
          return Login();
        }
    );
  }
}
class UserHelper {
  static saveUser(User user) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    Map<String, dynamic> userData = {
      "id": user.uid,
      "email": user.email,
      //"last_login": user.metadata.lastSignInTime?.millisecondsSinceEpoch,
      //"created_at": user.metadata.creationTime?.millisecondsSinceEpoch,
      "role": "user",
      "build_number": buildNumber,
    };
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        //"last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "build_number": buildNumber,
      });
    } else {
      await _db.collection("users").doc(user.uid).set(userData);
    }
    //await _saveDevice(user);
  }
}*/

/*
class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}
class _MainPageState extends State<MainPage> {
  //final newUser = FirebaseAuth.instance.currentUser ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //debugShowCheckedModeBanner: false,
      body: StreamBuilder<User?>(
        //register สำเร็จแล้วเข้าแอปได้เลย
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){

          User? user = FirebaseAuth.instance.currentUser;

          if(snapshot.connectionState == ConnectionState.waiting){
            const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            const Center(child: Text('something went wrong!'),);
          }
          else if(snapshot.hasData && snapshot.data != null) {

            //User? user = FirebaseAuth.instance.currentUser;
            FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .get()
                .then((DocumentSnapshot docs) {
              if (docs.get('role') == "Teacher") {
                return TeacherHomePage();
              }
              else if (docs.get('role') == "Student"){
                return TipPage();
              }
              else{
                print('document not in database');
                return Login();
              }
            });
                //return ;
              //}
            //});
            //กรณีอื่นๆ เป็น นศ.
            //return TipPage();
          }

          return Login();
        }
      ),

    );
  }
}
*/

//new
class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //db aunt firebase api
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //db
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    route();
    return Scaffold(
      backgroundColor:  Colors.white,
      // appBar: AppBar(
      //   title: Align(
      //     alignment: Alignment.bottomLeft,
      //     child: Text(
      //       'DENTIST',
      //       style: TextStyle(color: Colors.white, fontSize: 65,fontWeight: FontWeight.bold),
      //     ),
      //   ),
      //   leadingWidth: 40,
      //   toolbarHeight: 100,
      //   backgroundColor: Colors.cyan.shade400,
      // ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  // child: Container(
                  //     width: 200,
                  //     height: 250,
                  //     /*decoration: BoxDecoration(
                  //         color: Colors.red,
                  //         borderRadius: BorderRadius.circular(50.0)),*/
                  //     child: Image.asset("images/dentist.png")
                  // ),
                  child: Text(
                    'TU IVAR',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
                        /*shadows: <Shadow>[
                          Shadow(
                            offset: Offset(3.0, 3.0),
                            blurRadius: 2.0,
                            color: Colors.grey.withOpacity(0.3),
                          ),],*/
                          color: Colors.cyan.shade400,
                          fontSize: 90,
                          fontWeight: FontWeight.w400
                      ),
                    ),
                  ),

                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height/8,
              ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 600,
                        child: TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Please input your email.'),
                            EmailValidator(errorText: 'Invalid email address. Please try again.')
                          ]),
                          controller: _emailController, //db
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(13))),
                            labelText: 'Email : ',
                            hintText: 'Enter your email',
                            prefixIcon: const Icon(Icons.person,size: 45.0, color: Colors.black54),
                          ),
                          style: TextStyle(
                              fontSize: 30.0,
                              height: 2.0,
                              color: Colors.black
                          ),
                        ),
                      ),SizedBox(height: 20,),
                      Container(
                        width: 600,
                        child: TextFormField(
                          validator: MultiValidator([
                            RequiredValidator(errorText: 'Please input your password.'),
                            MinLengthValidator(6, errorText: 'Password must be at least 6')
                          ]),
                          obscureText: true,
                          controller: _passwordController,  //db
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(13))),
                            labelText: 'Password : ',
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(Icons.lock,size: 45.0, color: Colors.black54),
                          ),
                          style: TextStyle(
                              fontSize: 30.0,
                              height: 2.0,
                              color: Colors.black
                          ),
                        ),
                      ),
                      SizedBox(
                          height: 20
                      ),
                      Container(
                        width: 600,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              child: Text('Forgot Password?', style: TextStyle(color: Colors.grey, fontSize: 22, decoration: TextDecoration.underline),),
                              onTap: () {
                                Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) => Forgotpassword()));
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 36,
                      ),
                      Container(
                        height: 80,
                        width: 350,
                        decoration: BoxDecoration(
                            color:  Colors.cyan.shade400, borderRadius: BorderRadius.circular(20)),
                        child: TextButton(
                          onPressed: signIn,
                          child: Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

              SizedBox(
                height: MediaQuery.of(context).size.height/6,
              ),
              TextButton( //กดสมัครใหม่ ไปหน้า register
                onPressed: (){
                  //ล้างฟอร์ม
                  _formKey.currentState?.reset();

                  Navigator.of(context).push( //ไปหน้า register
                      MaterialPageRoute(builder: (context) => RegisterPage())
                  );
                },
                child: Text(
                  'New User? Create Account',
                  style: TextStyle(color: Colors.cyan, fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async{
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>  const Center(child: CircularProgressIndicator(),));

    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
      );
      // Navigator.canPop(context) ? Navigator.of(context) : null;

      route();

    } on Exception catch (e) {
      showDialog(
          context: context,
          builder:(BuildContext context) {
            return AlertDialog(
              title: const Text('error',style: TextStyle(fontSize: 35,)),
              content: Text(e.toString(), style: const TextStyle(fontSize: 25),),
              actions: [
                TextButton(
                  child: const Text('OK',style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    // Navigator.canPop(context) ? Navigator.of(context) : null;
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // Navigator.of(context).popUntil((route) => route.isFirst);

                  },
                ),
              ],
            );
          });
    }
    //close loading navigator
    //Navigator.canPop(context) ? Navigator.of(context) : null;
  }

  void route() {
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get()
        .then((DocumentSnapshot docs) {
      if (docs.get('role') == "Teacher") {
        Navigator.canPop(context) ? Navigator.of(context) : null;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  TeacherHomePage(),
          ),
        );
      }
      else if (docs.get('role') == "Student"){
        Navigator.canPop(context) ? Navigator.of(context) : null;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>  TipPage(),
          ),
        );
      }
      else{
        print('document not in database');
      }
    });
  }

}
