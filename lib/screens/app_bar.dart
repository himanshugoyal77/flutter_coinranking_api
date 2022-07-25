import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stock_market/screens/graph_screen.dart';

class MAppBar extends StatelessWidget {
  const MAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            CupertinoIcons.square_grid_2x2_fill,
            size: 29,
          ),
          IconButton(
            icon: Icon(
              Icons.settings,
              size: 28,
            ),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
