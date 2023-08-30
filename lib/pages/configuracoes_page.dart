import 'package:flutter/material.dart';
import 'package:imc_persistencia_interna/model/configuracoes.dart';

import '../data/configuracoes_repository.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  late ConfiguracoesRepository configuracoesRepository;
  Configuracoes configuracoes = Configuracoes.vazio();

  @override
  void initState() {
    obterDados();
    super.initState();
  }

  void obterDados() async {
    configuracoesRepository = await ConfiguracoesRepository.carregar();
    configuracoes = await configuracoesRepository.obterDados();
    nomeController.text = configuracoes.nome.toString();
    if (configuracoes.altura == 0) {
      alturaController.text = "";
    } else {
      alturaController.text = configuracoes.altura.toString();
    }
    setState(() {});
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações do usuário')),
      body: Form(
        key: _globalKey,
        child: ListView(children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Column(
              children: [
                const Text(
                  'Configuraçõs do usuário',
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  validator: (String? value) {
                    if (validaNome(value)) {
                      return null;
                    } else {
                      if (nomeController.text.isEmpty) {
                        return 'O campo nome não pode ficar em branco';
                      }
                      return 'O campo nome deve ter no mínimo 3 caracteres';
                    }
                  },
                  controller: nomeController,
                  decoration: const InputDecoration(
                    hintText: 'Digite seu nome',
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black45),
                    label: Text(
                      'Nome',
                      style: TextStyle(fontSize: 18),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (String? value) {
                    if (validaDouble(value)) {
                      return null;
                    } else {
                      if (alturaController.text.isEmpty) {
                        return 'O campo altura não pode ficar em branco';
                      }
                      return 'O campo altura não pode ser menor ou igual a zero';
                    }
                  },
                  keyboardType: TextInputType.number,
                  controller: alturaController,
                  decoration: const InputDecoration(
                    hintText: 'Digite sua altura',
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black45),
                    label: Text(
                      'Altura',
                      style: TextStyle(fontSize: 18),
                    ),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(borderSide: BorderSide()),
                  ),
                ),
                const SizedBox(height: 28),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      if (_globalKey.currentState!.validate()) {
                        configuracoes.nome = nomeController.text;
                        configuracoes.altura =
                            double.parse(alturaController.text);
                        configuracoesRepository.salvar(configuracoes);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Salvando informações'),
                          backgroundColor: Colors.black87,
                          behavior: SnackBarBehavior.floating,
                          elevation: 150.0,
                        ));
                        Navigator.pushReplacementNamed(context, "/home");
                      }
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40))),
                    child: const Text(
                      'Cadastrar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      configuracoesRepository.reiniciar();
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Resetando informações'),
                        backgroundColor: Colors.black87,
                        behavior: SnackBarBehavior.floating,
                        elevation: 150.0,
                      ));
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 0.7, color: Colors.black87),
                            borderRadius: BorderRadius.circular(40))),
                    child: const Text(
                      'Apagar',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
