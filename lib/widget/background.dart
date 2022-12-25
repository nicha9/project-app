import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/tipBG3.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white10, BlendMode.overlay),
          ),
        ),
      ),
    );
  }

}