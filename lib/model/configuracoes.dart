import 'package:hive/hive.dart';

part 'configuracoes.g.dart';

@HiveType(typeId: 0)
class Configuracoes {
  @HiveField(0)
  String _nome = "";

  @HiveField(1)
  double _altura = 0;

  Configuracoes(this._nome, this._altura);
  Configuracoes.vazio();

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }
}
