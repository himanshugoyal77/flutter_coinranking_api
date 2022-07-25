import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:stock_market/provider/limit_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReadData extends StatefulWidget {
  String name;
  ReadData({Key? key, required this.name}) : super(key: key);

  @override
  State<ReadData> createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {
  late TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int ups = 0;
    int downs = 0;
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('data')
            .doc(widget.name)
            .collection("name")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
              child: addElement(snapshot.data!).isNotEmpty
                  ? Center(
                      child: Container(
                        child: SfCircularChart(
                          tooltipBehavior: _tooltipBehavior,
                          legend: Legend(isVisible: true),
                          series: <CircularSeries>[
                            // Render pie chart

                            PieSeries<ChartData, String>(
                                dataSource: res,
                                pointColorMapper: (ChartData data, _) =>
                                    data.color,
                                xValueMapper: (ChartData data, int index) =>
                                    data.x,
                                yValueMapper: (ChartData data, int index) =>
                                    data.y,
                                dataLabelSettings:
                                    DataLabelSettings(isVisible: true),
                                enableTooltip: true,
                                explode: true,
                                explodeIndex: 0,
                                name: "% voets")
                          ],
                        ),
                      ),
                    )
                  : Text(cDown.toString())
            
              );
        },
      ),
    );
  }
}

List<ChartData> res = [];
int cUp = 0;
int cDown = 0;

List addElement(QuerySnapshot<Object?> doc) {
  for (int i = 0; i < doc.size; i++) {
    if (doc.docs[i]["up"] == 1) {
      cUp++;
    }
    if (doc.docs[i]["down"] == 1) {
      cDown++;
    }
  }
  res.add(ChartData("up", cUp, Color.fromARGB(255, 58, 225, 136)));
  res.add(ChartData("down", cDown, Color.fromARGB(195, 244, 70, 70)));

  print(cUp);
  print(cDown);

  return [cUp, cDown];
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}
