import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'forgotpassword.dart';
import 'teacherHome.dart';
import 'register.dart';
import 'tip.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

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

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Center(
                  child: Text(
                    'TU IVAR',
                    style: GoogleFonts.quicksand(
                      textStyle: TextStyle(
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
              TextButton(
                onPressed: (){
                  _formKey.currentState?.reset();

                  Navigator.of(context).push(
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

                    Navigator.pop(context);
                    Navigator.pop(context);

                  },
                ),
              ],
            );
          });
    }

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
