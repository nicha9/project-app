
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test_project_db/widget/createGraph.dart';
import 'package:test_project_db/model/resultModel.dart';

class OverallGraph extends StatefulWidget{

  String pattern;
  OverallGraph(this.pattern);

  @override
  State<OverallGraph> createState() => _OverallGraphState();
}

class _OverallGraphState extends State<OverallGraph> {
  List<FetchData> _item = [];


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        left: 50,
        right: 50,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [BoxShadow(
            blurRadius: 14,
            offset: Offset(0,3),
            color: Colors.grey.shade200,
          )]
      ),
      child: StreamBuilder<List<FetchData>>(
        stream: readAveData(),
        builder: (context, AsyncSnapshot<List<FetchData>> snapshot) {
          if (snapshot.hasError) {
            return Text('something went wrong! ${snapshot.error}');
          }
          else if (snapshot.hasData) {
            _item = snapshot.data!;

            return SfCartesianChart(
              primaryXAxis: CategoryAxis(
                  labelStyle: TextStyle(fontSize: 20),
                  arrangeByIndex: false
              ),
              enableAxisAnimation: true,

              legend: Legend(isVisible: true,position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<FetchData, String>>[
                LineSeries<FetchData, String>(
                  dataSource: _item,
                  xValueMapper: (FetchData item, _) => 'trial ' + item.trial.toString(),
                  yValueMapper: (FetchData item, _) => item.score,
                  name: 'Overall errors',

                ),

              ],
            );
          }else {
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
  Stream <List<FetchData>> readAveData() => FirebaseFirestore.instance
      .collection('average').where('id', isEqualTo: widget.pattern).orderBy('trial') //filter data
      .snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => FetchData.fromJson(doc.data())).toList());
}

class FetchData {
  final String id;
  final int score;
  final int trial;
  FetchData({
    required this.id,
    required this.score,
    required this.trial,
  });
  Map<String, dynamic> toJson() => {
    'id': id,
    'score': score,
    'trial': trial
  };
  static FetchData fromJson(Map<String, dynamic> json) => FetchData(
      id: json['id'],
      score: json['score'],
      trial: json['trial']
  );
}