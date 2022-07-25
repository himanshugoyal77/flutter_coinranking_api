import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_market/provider/limit_provider.dart';
import 'package:stock_market/screens/graph_screen.dart';

class predictionScreen extends StatefulWidget {
  final id;
  final name;
  const predictionScreen({Key? key, required this.id, required this.name})
      : super(key: key);

  @override
  State<predictionScreen> createState() => _predictionScreenState();
}

class _predictionScreenState extends State<predictionScreen> {
  bool isLeftClicked = false;
  bool isRightClicked = false;
  bool isVoted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLeftClicked = isLeftClicked;
    isRightClicked = isRightClicked;
  }

  @override
  Widget build(BuildContext context) {
    String formatter = DateFormat('yMd').format(DateTime.now()); // 28/03/2020
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm:ss').format(DateTime.now());
    final isClicked = Provider.of<LimitProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Predict",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black87),
          ),
          const SizedBox(
            height: 6,
          ),
          Container(
            padding: const EdgeInsets.all(18),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromARGB(226, 249, 245, 245),
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(255, 188, 184, 184),
                    offset: Offset(
                      2.0,
                      2.0,
                    ),
                    blurRadius: 0.2,
                    spreadRadius: 0.2,
                  ), //BoxS
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showBottomSheetx(context, widget.name);
                    isVoted
                        ? print("voted")
                        : setState(() {
                            isVoted = true;
                            isLeftClicked = true;
                            isRightClicked = false;

                            FirebaseFirestore.instance
                                .collection("data")
                                .doc(widget.name)
                                .collection("name")
                                .add({'up': 1, 'down': 0});
                          });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Center(child: Icon(Icons.arrow_upward_outlined)),
                    decoration: BoxDecoration(
                        color: isLeftClicked
                            ? const Color(0xff01CD5F)
                            : Color.fromARGB(115, 110, 109, 109),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                            color: Color.fromARGB(115, 110, 109, 109))),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("BITCOIN"),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(formattedDate),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(formatter),
                  ],
                ),
                InkWell(
                  onTap: () {
                    showBottomSheetx(context, widget.name);
                    isVoted
                        ? print(isVoted)
                        : setState(() {
                            isVoted = true;
                            isRightClicked = true;
                            isLeftClicked = false;
                            FirebaseFirestore.instance
                                .collection("data")
                                .doc(widget.name)
                                .collection("name")
                                .add({'up': 0, 'down': 1});
                          });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    child: Center(child: Icon(Icons.arrow_downward_outlined)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: isRightClicked
                            ? const Color(0xffFF3F3F)
                            : Color.fromARGB(115, 110, 109, 109),
                        border: Border.all(
                          color: isClicked.isRightClicked
                              ? const Color(0xffFF3F3F)
                              : const Color.fromARGB(115, 110, 109, 109),
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
