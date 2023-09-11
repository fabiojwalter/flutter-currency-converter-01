import 'package:currency/api_client.dart';
import 'package:flutter/material.dart';
import 'package:currency/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiClient apiClient = ApiClient();
  double? usd;
  double? euro;
  double? ars;
  double? btc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                euro = snapshot.data?['results']['currencies']['EUR']['buy'];
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
                          color: Colors.white,
                          size: 64,
                        ),
                        TextField(
                            controller: null,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            decoration: InputDecoration(
                                border: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.amber)),
                                labelText: 'BRL',
                                labelStyle: TextStyle(
                                  color: Colors.amber.shade400,
                                ))),
                        TextField(
                          controller: null,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber)),
                            labelText: 'USD',
                            labelStyle: TextStyle(
                              color: Colors.amber.shade400,
                            ),
                          ),
                        ),
                        TextField(
                          controller: null,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber)),
                            labelText: 'ARS',
                            labelStyle: TextStyle(
                              color: Colors.amber.shade400,
                            ),
                          ),
                        ),
                        TextField(
                          controller: null,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber)),
                            labelText: 'BTC',
                            labelStyle: TextStyle(
                              color: Colors.amber.shade400,
                            ),
                          ),
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
