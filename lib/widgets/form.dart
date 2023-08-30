import 'package:flutter/material.dart';
import '../model/imc.dart';

class FormImc extends StatefulWidget {
  const FormImc({super.key});

  @override
  State<FormImc> createState() => _FormImcState();
}

class _FormImcState extends State<FormImc> {
  List<Imc> imcs = [];
  bool possuiItem = false;
  List<List<String>> sexos = [];
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
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
    return Center(
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
                    const SizedBox(
                      height: 16,
                    ),
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
                        hintStyle:
                            TextStyle(fontSize: 14, color: Colors.black45),
                        label: Text(
                          'Altura',
                          style: TextStyle(fontSize: 18),
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: OutlineInputBorder(borderSide: BorderSide()),
                      ),
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
                        onPressed: () {
                          if (_globalKey.currentState!.validate()) {
                            Imc imc = Imc(double.parse(alturaController.text),
                                double.parse(pesoController.text));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Adicionando imc'),
                              backgroundColor: Colors.black87,
                              behavior: SnackBarBehavior.floating,
                              elevation: 150.0,
                            ));
                            Navigator.pop(context, imc);
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
    );
  }
}
