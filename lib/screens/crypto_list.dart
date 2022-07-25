import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stock_market/components/crypto_currency.dart';
import 'package:stock_market/controller/api_controller.dart';
import 'package:stock_market/model/price_modal.dart';

class CryptoList extends StatelessWidget {
  const CryptoList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Popular Cryptos"),
         const SizedBox(height: 12,),
          FutureBuilder<List<Coin>>(
            future: CryptoApi.getCoins(),
            builder: (BuildContext context, AsyncSnapshot<List<Coin>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                List<Coin> coins = snapshot.data!;
                return Column(
                  children: coins.map((coin) => CryptoCurrency(coin: coin)).toList(),
                );
              }
              return const Text("Somrthing went wrong");
            },
          ),
        ],
      ),
    );
  }
}
