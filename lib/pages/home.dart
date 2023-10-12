import 'package:currency/api_client.dart';
import 'package:flutter/material.dart';
import 'package:currency/constants.dart';

import '../components/textfields.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiClient apiClient = ApiClient();

  late double usd;
  late double eur;
  late double ars;
  late double btc;

  var controllerBRL = TextEditingController();
  var controllerUSD = TextEditingController();
  var controllerEUR = TextEditingController();
  var controllerARS = TextEditingController();
  var controllerBTC = TextEditingController();

  void inputBRLChanged(String text) {
    if (text.isEmpty || controllerBRL.text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    controllerUSD.text = (real / usd).toStringAsFixed(2);
    controllerEUR.text = (real / eur).toStringAsFixed(2);
    controllerARS.text = (real / ars).toStringAsFixed(2);
    controllerBTC.text = (real / btc).toStringAsFixed(8);
  }

  void inputUSDChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    double real = (dolar * usd);
    controllerBRL.text = real.toStringAsFixed(2);
    controllerEUR.text = (real / eur).toStringAsFixed(2);
    controllerARS.text = (real / ars).toStringAsFixed(2);
    controllerBTC.text = (real / btc).toStringAsFixed(8);
  }

  void inputEURChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    double real = (euro * eur);
    controllerBRL.text = real.toStringAsFixed(2);
    controllerUSD.text = (real / usd).toStringAsFixed(2);
    controllerARS.text = (real / ars).toStringAsFixed(2);
    controllerBTC.text = (real / btc).toStringAsFixed(8);
  }

  void inputARSChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double peso = double.parse(text);
    double real = (peso * ars);
    controllerBRL.text = real.toStringAsFixed(2);
    controllerEUR.text = (real / eur).toStringAsFixed(2);
    controllerUSD.text = (real / usd).toStringAsFixed(2);
    controllerBTC.text = (real / btc).toStringAsFixed(8);
  }

  void inputBTCChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double bitcoin = double.parse(text);
    double real = (bitcoin * btc);
    controllerBRL.text = real.toStringAsFixed(2);
    controllerEUR.text = (real / eur).toStringAsFixed(2);
    controllerARS.text = (real / ars).toStringAsFixed(2);
    controllerUSD.text = (real / usd).toStringAsFixed(2);
  }

  void _clearAll() {
    controllerBRL.clear();
    controllerARS.clear();
    controllerEUR.clear();
    controllerBTC.clear();
    controllerUSD.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.amber.shade600,
        centerTitle: true,
        title: const Text("Currency converter"),
      ),
      body: FutureBuilder<Map>(
          future: apiClient.get(url: urlQuotations),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(
                    child: Text('Carregando dados',
                        style: TextStyle(
                          color: Colors.amber,
                        )));
              default:
                if (snapshot.hasError) {
                  return const Center(
                      child: Text('Erro carregando dados',
                          style: TextStyle(
                            color: Colors.amber,
                          )));
                }
                usd = snapshot.data?['results']['currencies']['USD']['buy'];
                eur = snapshot.data?['results']['currencies']['EUR']['buy'];
                ars = snapshot.data?['results']['currencies']['ARS']['buy'];
                btc = snapshot.data?['results']['currencies']['BTC']['buy'];
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          color: Colors.amber,
                          size: 128,
                        ),
                        const Divider(),
                        CurrencyTextField(
                          controller: controllerBRL,
                          actionChange: inputBRLChanged,
                          clearFunction: _clearAll,
                          labelText: 'Real',
                          prefix: 'R\$',
                        ),
                        const Divider(),
                        CurrencyTextField(
                          controller: controllerUSD,
                          actionChange: inputUSDChanged,
                          clearFunction: _clearAll,
                          labelText: 'Dolar',
                          prefix: '\$',
                        ),
                        const Divider(),
                        CurrencyTextField(
                          controller: controllerEUR,
                          actionChange: inputEURChanged,
                          clearFunction: _clearAll,
                          labelText: 'Euro',
                          prefix: '€',
                        ),
                        const Divider(),
                        CurrencyTextField(
                          controller: controllerARS,
                          actionChange: inputARSChanged,
                          clearFunction: _clearAll,
                          labelText: 'Peso',
                          prefix: 'ARS',
                        ),
                        const Divider(),
                        CurrencyTextField(
                          controller: controllerBTC,
                          actionChange: inputBTCChanged,
                          clearFunction: _clearAll,
                          labelText: 'Bitcoin',
                          prefix: '฿',
                        ),
                      ],
                    ),
                  ),
                );
            }
          }),
    );
  }
}
