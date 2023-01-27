import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'INR';
  List<int> coinValues = [];
  int BTCrate;
  int ETHrate;
  int LTCrate;
  Map<String, int> coinValue;
  // CoinData coinData = CoinData(selectedCurrency: 'INR');

  void updateUI(String value) async {
    selectedCurrency = value;
    var BTCcoinRate = await CoinData(
            selectedCurrency: selectedCurrency, selectedCrypto: "BTC")
        .getCoinData();

    var ETHcoinRate = await CoinData(
            selectedCurrency: selectedCurrency, selectedCrypto: "ETH")
        .getCoinData();
    var LTCcoinRate = await CoinData(
            selectedCurrency: selectedCurrency, selectedCrypto: "LTC")
        .getCoinData();

    setState(() {
      BTCrate = BTCcoinRate['rate'].round();
      ETHrate = ETHcoinRate['rate'].round();
      LTCrate = LTCcoinRate['rate'].round();
    });

    coinValue = {'BTC': BTCrate, 'ETH': ETHrate, 'LTC': LTCrate};

    return;
  }

  void initState() {
    super.initState();
    updateUI("INR");
  }

  CupertinoPicker getIosItems() {
    List<Text> widgetList = [];

    for (String currency in currenciesList) {
      var newItem = Text(currency);
      widgetList.add(newItem);
    }

    return CupertinoPicker(
      looping: true,
      useMagnifier: true,
      magnification: 1.2,
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index];
          var coinRate =
              CoinData(selectedCurrency: selectedCurrency).getCoinData();
          // rate=coinRate['rate'];
        });
      },
      children: widgetList,
    );
  }

  DropdownButton getAndroidItems() {
    List<DropdownMenuItem<String>> widgetList = [];

    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      widgetList.add(newItem);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: widgetList,
      onChanged: (value) {
        updateUI(value);
      },
    );
  }

  // List<Widget> constructCards() {
  //   List<Widget> cardWidget = [];
  //   for (String crypto in cryptoList) {
  //     var newWidgetItem = Card(
  //       color: Colors.lightBlueAccent,
  //       elevation: 5.0,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10.0),
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
  //         child: Text(
  //           '1 $crypto = $ETHrate $selectedCurrency',
  //           textAlign: TextAlign.center,
  //           style: TextStyle(
  //             fontSize: 20.0,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     );
  //
  //     cardWidget.add(newWidgetItem);
  //   }
  //
  //   return cardWidget;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: [
                CryptoCard(
                  cryptoCurrency: "BTC",
                  value: coinValue['BTC'].toString(),
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: "ETH",
                  value: coinValue['ETH'].toString(),
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: "LTC",
                  value: coinValue['LTC'].toString(),
                  selectedCurrency: selectedCurrency,
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? getAndroidItems() : getIosItems(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  //2: You'll need to able to pass the selectedCurrency, value and cryptoCurrency to the constructor of this CryptoCard Widget.
  const CryptoCard({
    this.value,
    this.selectedCurrency,
    this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
