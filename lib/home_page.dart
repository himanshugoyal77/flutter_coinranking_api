import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stock_market/screens/graph_screen.dart';

import 'screens/app_bar.dart';
import 'screens/crypto_list.dart';
import 'screens/wallets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                MAppBar(),
                SizedBox(
                  height: 30,
                ),
                Center(child: CryptoList())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
