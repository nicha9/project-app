import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_project_db/createGraph.dart';

import 'histList.dart';

class StudentDetail extends StatefulWidget {
  String id;
  String name;
  StudentDetail(this.id, this.name);

  @override
  State<StudentDetail> createState() => _StudentDetailState();
}

class _StudentDetailState extends State<StudentDetail> {
  @override
  Widget build(BuildContext context) {

    final patterns = ['pattern1', 'pattern2'];

    print(patterns.length);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name, style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),),
          centerTitle: false,
          toolbarHeight: 100,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              color: Colors.cyan.shade400,
            ),
          ),
        ),

        // pattern1 result list
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(height: 30,),
              Column(
                //padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Text(
                    'Overall Preformance',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.cyan.shade400),
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500, color: Colors.cyan.shade400),
                  ),
                ],

              ),
              const SizedBox(height: 10),
              Container(
                height: 350,
                  child: CarouselSlider.builder(
                      options: CarouselOptions(
                        height: 340,
                        enableInfiniteScroll: false,
                        //viewportFraction: 1,
                      ),
                      itemCount: patterns.length,
                      itemBuilder: (context, index, realIndex){
                        final pattern = patterns[index];

                        return buidGraph(pattern, index);
                      },
                  ),

                // child: CreateGraph(id, 'pattern1'),
              ),SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: <Widget>[
                    const Text(
                      'Pattern 1',
                      style: TextStyle(
                          fontSize: 28, fontWeight: FontWeight.w500, color: Colors.cyan),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 350,
                child: HistList(widget.id,'pattern1',false),
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
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 350,
                child: HistList(widget.id, 'pattern2', false),
              ),

            ],
          ),
        )
    );

  }

  Widget buidGraph(String pattern, int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      // width: MediaQuery.of(context).size.width * 6,
        child: CreateGraph(widget.id,pattern),
    );
  }
}