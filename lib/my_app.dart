import 'package:imc_persistencia_interna/pages/configuracoes_page.dart';
import 'package:imc_persistencia_interna/pages/form_page.dart';
import 'package:imc_persistencia_interna/pages/home_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/home': (context) => const MyHomePage(),
        '/form': (context) => const FormPage(),
        '/config': (context) => const ConfiguracoesPage(),
      },
      home: const MyHomePage(),
    );
  }
}
