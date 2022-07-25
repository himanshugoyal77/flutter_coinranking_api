import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:stock_market/screens/graph_screen.dart';

import '../../model/price_modal.dart';

class CryptoCurrency extends StatelessWidget {
  final Coin coin;

  const CryptoCurrency({
    Key? key,
    required this.coin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => GraphScreen(id: coin.uuid, name: coin.name, 
                  price: coin.price, change: coin.change, url: coin.iconUrl,)));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!.withOpacity(0.5)),
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xffF3F3F3),
            boxShadow: [
              BoxShadow(
                offset: const Offset(5, 3),
                blurRadius: 15,
                spreadRadius: 1,
                color: Colors.grey[200]!,
              ),
            ],
          ),
          height: 85,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 17),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      SvgPicture.network(
                        coin.iconUrl,
                        fit: BoxFit.cover,
                        height: 27,
                        width: 27,
                      ),
                      const SizedBox(
                        width: 18,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            coin.name.toString().substring(
                                  0,
                                ),
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.w600,
                                fontSize: 18),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "${coin.symbol}/USD",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "\$${NumberFormat("#,##0.00", "en_US").format(coin.price)}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 3,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                            coin.change > 0
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            size: 25,
                            color: getColor(coin.change)),
                        Text(
                          "${(coin.change.abs()).toStringAsFixed(2)}%",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: getColor(coin.change)),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
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
