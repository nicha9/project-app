import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project_db/histList.dart';
import 'package:test_project_db/resultModel.dart';
import 'package:test_project_db/userModel.dart';

import 'menubar.dart';

class SubmitPage extends StatelessWidget {
  final userID = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trial', style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),),
        centerTitle: false,
        toolbarHeight: 100,
        leading: IconButton(icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.canPop(context) ? Navigator.of(context) : null;
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => Menubar()));
          },
        ),
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

      // pattern1 result list
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(height: 30,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  const Text(
                    'Pattern 1',
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w500, color: Colors.cyan),
                  ),
                  // const Spacer(),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'View All',
                  //       style: TextStyle(
                  //           fontSize: 16, color: Colors.cyan.shade400),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Container(
                  //         padding: const EdgeInsets.all(3),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(5),
                  //             color: Colors.cyan.shade400),
                  //         child: const Icon(
                  //           Icons.keyboard_arrow_right_rounded,
                  //           size: 14,
                  //           color: Colors.white,
                  //         ))
                  //   ],
                  // )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 370,
              //child: Flexible (
                child: HistList(userID,'pattern1', true),
              //)
            ),

            const SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: <Widget>[
                  const Text(
                    'Pattern 2',
                    style: TextStyle(
                        fontSize: 28, fontWeight: FontWeight.w500, color: Colors.cyan),
                  ),
                  // const Spacer(),
                  // Row(
                  //   children: [
                  //     Text(
                  //       'View All',
                  //       style: TextStyle(
                  //           fontSize: 16, color: Colors.cyan.shade400),
                  //     ),
                  //     const SizedBox(width: 10),
                  //     Container(
                  //         padding: const EdgeInsets.all(3),
                  //         decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(5),
                  //             color: Colors.cyan.shade400),
                  //         child: const Icon(
                  //           Icons.keyboard_arrow_right_rounded,
                  //           size: 14,
                  //           color: Colors.white,
                  //         ))
                  //   ],
                  // )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 350,
              child: HistList(userID, 'pattern2', true),
            ),

          ],
        ),
      )
    );

    //);
  }

  // Stream <List<Users>> readUsers() => FirebaseFirestore.instance
  //     .collection('pattern1').where('id', isEqualTo: FirebaseAuth.instance.currentUser?.uid) //filter data
  //     .snapshots().map((snapshot) =>
  //     snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
}

// class ResultItem extends StatelessWidget {
//   final Item item;
//   const ResultItem({
//     Key? key,
//     required this.item,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(30),
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.35,
//         width: MediaQuery.of(context).size.width * 0.6,
//         color: cat.color.withOpacity(0.6),
//         child: Stack(
//           children: [
//             Positioned(
//               bottom: -10,
//               right: -10,
//               height: 100,
//               width: 100,
//               child: Transform.rotate(
//                   angle: 12,
//                   child: SvgPicture.asset(
//                     'assets/Paw_Print.svg',
//                     color: cat.color,
//                     fit: BoxFit.cover,
//                   )),
//             ),
//             Positioned(
//               top: 100,
//               left: -25,
//               height: 100,
//               width: 100,
//               child: Transform.rotate(
//                   angle: -11.5,
//                   child: SvgPicture.asset(
//                     'assets/Paw_Print.svg',
//                     color: cat.color,
//                     fit: BoxFit.cover,
//                   )),
//             ),
//             Positioned(
//               bottom: -10,
//               right: -80,
//               left: 20,
//               child: Image.asset(
//                 cat.image,
//                 height: MediaQuery.of(context).size.height * 0.25,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           cat.name,
//                           style: poppins.copyWith(
//                               fontSize: 16,
//                               color: black,
//                               fontWeight: FontWeight.bold),
//                         ),
//                         Row(
//                           children: [
//                             const Icon(
//                               Icons.location_on_outlined,
//                               color: blue,
//                               size: 16,
//                             ),
//                             Text(
//                               'Distance (${cat.distance} Km)',
//                               style: poppins.copyWith(
//                                 fontSize: 12,
//                                 color: black.withOpacity(0.6),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     padding: const EdgeInsets.all(5),
//                     decoration: const BoxDecoration(
//                         shape: BoxShape.circle, color: white),
//                     child: Icon(
//                       cat.fav
//                           ? Icons.favorite_rounded
//                           : Icons.favorite_outline_rounded,
//                       color: cat.fav ? red : black.withOpacity(0.6),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }