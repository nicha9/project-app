import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class Forgotpassword extends StatefulWidget{
  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),),
        centerTitle: false,
        toolbarHeight: 80,
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
      body: Padding(
        padding: EdgeInsets.all(60),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Enter your email and we will send you a reset password link.',
                textAlign: TextAlign.center,
              style: TextStyle(fontSize: 35),),
              SizedBox(height: 30,),
              TextFormField(
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Please input your email.'),
                  EmailValidator(errorText: 'Invalid email address. Please try again.')
                ]),
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(13))),
                  labelText: 'Email : ',

                ),
                style: TextStyle(
                    fontSize: 30.0,
                    height: 2.0,
                    color: Colors.black
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(60),
                  backgroundColor: Colors.cyan
                ),
                  onPressed: resetpassword,
                  icon: Icon(Icons.email, color: Colors.white,),
                label: Text('Reset Password', style: TextStyle(fontSize: 30),),
              ),
            ],
          ),
        ),

      ),
    );

  }
  Future resetpassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) =>  const Center(child: CircularProgressIndicator(),));

    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(
          context: context,
          builder:(BuildContext context) {
            return AlertDialog(
              title: const Text('done',style: TextStyle(fontSize: 35,)),
              content: Text('reset password email was send. If you do not see it, please check in your spam folder.', style: const TextStyle(fontSize: 25),),
              actions: [
                TextButton(
                  child: const Text('OK',style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ],
            );
          });

    } on FirebaseAuthException catch (e) {
      print(e);
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
                  },
                ),
              ],
            );
          });
    }
    
  }

}
