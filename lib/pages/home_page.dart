import 'package:imc_persistencia_interna/data/imc_dao.dart';
import 'package:imc_persistencia_interna/widgets/card_imc.dart';
import 'package:flutter/material.dart';
import '../model/imc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Imc> imcs = [];
  ImcDao imcDao = ImcDao();
  bool possuiItem = false;

  bool validaNome(String? value) {
    if (value != null && value.length > 2) {
      return true;
    }
    return false;
  }

  bool validaDouble(String? value) {
    if (value != null && value.isNotEmpty) {
      double number = double.parse(value);
      if (number > 0) {
        return true;
      }
      return false;
    }
    return false;
  }

  @override
  void initState() {
    obterDados();
    super.initState();
  }

  void obterDados() async {
    imcs = await imcDao.pegarImcs();
    verificaItem();
    setState(() {});
  }

  void removerCard(int id) {
    imcDao.removerImc(id);
    obterDados();
  }

  void verificaItem() {
    if (imcs.isEmpty) {
      possuiItem = false;
    }
    possuiItem = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registros de IMCs'),
        ),
        drawer: Drawer(
            child: Column(
          children: [
            ListTile(
              title: const Text("Configurações"),
              leading: const Icon(Icons.manage_accounts),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/config");
              },
            ),
          ],
        )),
        body: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 70),
          child: FutureBuilder<List<Imc>>(
              future: imcDao.pegarImcs(),
              builder: (context, snapshot) {
                List<Imc>? items = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando'),
                        ],
                      ),
                    );
                  case ConnectionState.waiting:
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando'),
                        ],
                      ),
                    );
                  case ConnectionState.active:
                    return const Center(
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('Carregando'),
                        ],
                      ),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasData && items != null) {
                      if (items.isNotEmpty) {
                        return ListView.builder(
                          itemCount: imcs.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Imc imc = items[index];
                            return CardImc(
                              imc: imc,
                              removerCard: removerCard,
                              verificarItem: verificaItem,
                            );
                          },
                        );
                      }
                      return const Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.error_outline,
                              size: 68,
                            ),
                            Text(
                              'Não há IMCs registrados',
                              style: TextStyle(fontSize: 32),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Text('Erro ao carregar as tarefas');
                }
              }),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Adicionar'),
          onPressed: () async {
            Navigator.pushNamed(context, '/form');
            obterDados();
          },
          tooltip: 'Adicionar imc',
          icon: const Icon(Icons.add),
        ),
      ),
    );
  }
}
