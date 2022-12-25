import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../model/resultModel.dart';

class CreateGraph extends StatefulWidget{
  String id;
  String pattern;
  CreateGraph(this.id, this.pattern);

  @override
  State<CreateGraph> createState() => _CreateGraphState();
}

class _CreateGraphState extends State<CreateGraph> {
  List<Item> _item = [];

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: Colors.white,
          boxShadow: [BoxShadow(
            blurRadius: 14,
            offset: Offset(0,3),
            color: Colors.grey.shade200,
          )]
      ),
      child: StreamBuilder<List<Item>>(
        stream: readData(),
        builder: (context, AsyncSnapshot<List<Item>> snapshot) {
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

              title: ChartTitle(text: widget.pattern),
              legend: Legend(isVisible: true,position: LegendPosition.bottom),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<Item, String>>[

                LineSeries<Item, String>(
                  dataSource: _item,
                  xValueMapper: (Item item, _) => 'trial ' + item.trial.toString(),
                  yValueMapper: (Item item, _) => item.score,
                  name: 'overall errors %',
                  //dataLabelSettings: DataLabelSettings(isVisible: true),
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

  Stream <List<Item>> readData() => FirebaseFirestore.instance
      .collection(widget.pattern).where('id', isEqualTo: widget.id).orderBy('trial') //filter data
      .snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

  Stream <List<Item>> readAllData() => FirebaseFirestore.instance
      .collection(widget.pattern).orderBy('trial') //filter data
      .snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => Item.fromJson(doc.data())).toList());

}
