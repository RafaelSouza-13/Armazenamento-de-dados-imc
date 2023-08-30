import 'package:flutter/material.dart';
import 'model/configuracoes.dart';
import 'my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:hive/hive.dart';
// import 'package:hive_generator/hive_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documents_directory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documents_directory.path);
  Hive.registerAdapter(ConfiguracoesAdapter());
  runApp(const MyApp());
}
