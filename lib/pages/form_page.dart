import 'package:flutter/material.dart';
import '../data/configuracoes_repository.dart';
import '../data/imc_dao.dart';
import '../model/configuracoes.dart';
import '../model/imc.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  bool possuiItem = false;
  TextEditingController pesoController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  ImcDao imcDao = ImcDao();
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
      appBar: AppBar(title: const Text("Cadastro de imc")),
      body: Center(
        child: Form(
            key: _globalKey,
            child: ListView(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  child: Column(
                    children: [
                      const Text(
                        'Preencha os campos',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        validator: (String? value) {
                          if (validaDouble(value)) {
                            return null;
                          } else {
                            if (pesoController.text.isEmpty) {
                              return 'O campo peso não pode ficar em branco';
                            }
                            return 'O campo altura não pode ser menor ou igual a zero';
                          }
                        },
                        keyboardType: TextInputType.number,
                        controller: pesoController,
                        decoration: const InputDecoration(
                          hintText: 'Digite seu peso',
                          hintStyle:
                              TextStyle(fontSize: 14, color: Colors.black45),
                          label: Text(
                            'Peso',
                            style: TextStyle(fontSize: 18),
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          border: OutlineInputBorder(borderSide: BorderSide()),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () async {
                            if (configuracoes.altura == 0) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return AlertDialog(
                                      title: const Text("Ausencia de dados"),
                                      content: const Text(
                                          "Voce precisa cadastrar seus dados"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pushReplacementNamed(
                                                  context, '/config');
                                            },
                                            child: const Text(
                                              "Cadastrar",
                                              style:
                                                  TextStyle(color: Colors.blue),
                                            )),
                                      ],
                                    );
                                  });
                              return;
                            }
                            if (_globalKey.currentState!.validate()) {
                              Imc imc = Imc(configuracoes.altura,
                                  double.parse(pesoController.text));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Adicionando imc'),
                                backgroundColor: Colors.black87,
                                behavior: SnackBarBehavior.floating,
                                elevation: 150.0,
                              ));
                              await imcDao.adicionarImc(imc);
                              Navigator.pushReplacementNamed(context, "/home");
                            }
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          child: const Text(
                            'Calcular',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
