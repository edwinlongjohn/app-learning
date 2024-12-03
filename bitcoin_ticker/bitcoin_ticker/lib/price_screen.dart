// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:bitcoin_ticker/component/custom_card.dart';
import 'package:bitcoin_ticker/offline_screen.dart';
import 'package:bitcoin_ticker/services/currency_rate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  List<String> coins = currenciesList;
  List<String> cryptoCurrencies = cryptoList;
  String currency = 'AUD';
  bool loading = false;
  String currencyRate = '?';
  List<Widget>? cards;
  String coin = 'BTC';

  CurrencyRate currencyApi = CurrencyRate();
  Future<void> getData(coin, currency) async {
    loading = true;
    try {
      var rate = await currencyApi.getExchange(coin, currency);
      rate = rate['rate'].toInt();
      currencyRate = rate.toString();
      setState(() {
        loading = false;
      });
    } catch (e) {
      if (mounted) {
        loading = false;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OfflineScreen(),
          ),
        );
      }
    }
  }

  Widget getPicker() {
    if (kIsWeb) {
      return androidDropdown();
    } else {
      if (Platform.isAndroid) {
        return androidDropdown();
      } else if (Platform.isIOS) {
        return iosPicker();
      } else {
        return Text('unkown');
      }
    }
  }

  Future<List<Widget>> coinCards() async {
    List<Widget> elements = [];
    for (var crypto in cryptoCurrencies.asMap().entries) {
      await getData(currency, crypto.value);
      elements.add(Padding(
        padding: crypto.key == 0
            ? EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0)
            : EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: CustomCard(
          currencyRate: currencyRate,
          loading: loading,
          currency: currency,
          coin: crypto.value,
        ),
      ));
    }
    return elements;
  }

  List<Widget> defaultCards() {
    List<Widget> elements = [];
    for (var crypto in cryptoCurrencies.asMap().entries) {
      elements.add(Padding(
        padding: crypto.key == 0
            ? EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0)
            : EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
        child: CustomCard(
          currencyRate: currencyRate,
          loading: loading,
          currency: currency,
          coin: crypto.value,
        ),
      ));
    }
    return elements;
  }

  Future<void> getCards() async {
    setState(() {
      loading = true;
    });
    cards = defaultCards();
    cards = await coinCards();
    setState(() {
      loading = false;
    });
  }

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (String coin in coins) {
      dropDownItem.add(DropdownMenuItem<String>(
        value: coin,
        child: Text(coin),
      ));
    }
    return DropdownButton(
      value: currency,
      items: dropDownItem,
      onChanged: (value) => {
        setState(() {
          currency = value!;
        }),
        getCards()
      },
    );
  }

  CupertinoPicker iosPicker() {
    List<Widget> dropDownItems = [];
    for (String coin in coins) {
      dropDownItems.add(
        Text(
          coin,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      );
    }

    return CupertinoPicker(
      itemExtent: 30,
      backgroundColor: Colors.lightBlue,
      onSelectedItemChanged: (selectedItem) {
        setState(() {
          currency = coins[selectedItem];
        });
        getCards();
      },
      children: dropDownItems,
    );
  }

  @override
  void initState() {
    super.initState();
    getCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: (cards ?? []) +
            [
              Container(
                height: 150.0,
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 30.0),
                color: Colors.lightBlue,
                child: androidDropdown(),
              ),
            ],
      ),
    );
  }
}
