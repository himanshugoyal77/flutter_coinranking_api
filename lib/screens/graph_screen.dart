import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:stock_market/components/prediction.dart';
import 'package:stock_market/components/read_data.dart';
import 'package:stock_market/model/history.dart';
import 'package:stock_market/provider/limit_provider.dart';
import 'package:stock_market/screens/app_bar.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:http/http.dart' as http;
import '../controller/history_controller.dart';

class GraphScreen extends StatefulWidget {
  final String id;
  final String name;
  final double price;
  final double change;
  final String url;
  const GraphScreen(
      {Key? key,
      required this.id,
      required this.name,
      required this.price,
      required this.change,
      required this.url})
      : super(key: key);

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  String dropdownValue = '200';
  late List postjson = [];

  @override
  void fetchData() async {
    final response = await http.get(
        Uri.parse(
            'https://coinranking1.p.rapidapi.com/coin/${widget.id}/history'),
        headers: {
          "Content-Type": "application/json",
          'X-RapidAPI-Key':
              '5f506045admsh19d29b93bba57d7p1a7e0djsne0bcbd6bbb86',
        });

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)["data"]["history"] as List;
      setState(() {
        postjson = result;
      });
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    late int setday = 200;
    int noLimit = Provider.of<LimitProvider>(context).limit;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),
            const MAppBar(),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, bottom: 12, top: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgPicture.network(
                    widget.url,
                    height: 27,
                    width: 27,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Text(
                "USD PRICE",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.price}",
                    style: const TextStyle(fontSize: 22, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0, right: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.change}%",
                    style:
                        TextStyle(fontSize: 18, color: getColor(widget.change)),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.trending_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            Provider.of<LimitProvider>(context, listen: false)
                                .changeLimit(int.parse(newValue));
                          });
                        },
                        items: <String>[
                          '200',
                          '100',
                          '50',
                          '${postjson.length}',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Text("Days Ago")
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //Initialize the chart widget
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                      bottom: 10,
                      right: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.circle_outlined,
                            size: 8,
                            color: Color.fromARGB(255, 15, 16, 16),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Icon(
                            Icons.graphic_eq,
                            color: Color.fromARGB(255, 5, 227, 251),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("Price")
                        ],
                      )),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    //height: 350,
                    child: SfCartesianChart(
                        primaryXAxis: NumericAxis(isVisible: false),
                        primaryYAxis: NumericAxis(isVisible: false),
                        borderWidth: 0,
                        plotAreaBorderWidth: 0,
                        // Enable legend
                        //legend: Legend(isVisible: true),
                        // Enable tooltip
                        tooltipBehavior: TooltipBehavior(enable: true),
                        series: <ChartSeries>[
                          SplineSeries<dynamic, num>(
                            isVisibleInLegend: true,
                            legendItemText: "price",
                            //animationDuration: 5000,
                            color: const Color.fromARGB(255, 5, 227, 251),
                            dataSource: postjson,
                            yValueMapper: (__, int index) {
                              if (index < noLimit) {
                                return double.parse(postjson[index]["price"]
                                    .toString()
                                    .substring(0, 5));
                              }
                            },
                            xValueMapper: (_, int index) {
                              if (index < noLimit) {
                                return postjson[index]["timestamp"];
                              }
                            },

                            // Enable data label
                          )
                        ]),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            // const Padding(
            //   padding: const EdgeInsets.all(18.0),
            //   child: Text(
            //     "Predict",
            //     style: TextStyle(
            //         fontSize: 22,
            //         fontWeight: FontWeight.w600,
            //         color: Colors.black87),
            //   ),
            // ),
            // Row(
            //   children: [
            //     ListTile(
            //       leading: Container(
            //         height: 50,
            //         width: 50,
            //         child: Center(child: Icon(Icons.arrow_upward_outlined)),
            //         decoration: BoxDecoration(

            //             border: Border.all(color: Colors.black45)),
            //       ),
            //     )
            //   ],
            // )
            predictionScreen(
              id: widget.id,
              name: widget.name,
            )
          ],
        ),
      ),
    );
  }
}

Color getColor(double change) {
  if (change > 0) {
    return const Color(0xff01CD5F);
  }

  return const Color(0xffFF3F3F);
}

Future<void> showBottomSheetx(context, name) {
  return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 400,
          child: Center(child: ReadData(name: name)),
        );
      });
}
