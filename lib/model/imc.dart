import 'dart:math';

class Imc {
  int _idImc = 0;
  double _imc = 0;
  String _classificacao = "";

  Imc(double altura, double peso) {
    _imc = peso / pow(altura, 2);
    _classificacao = selecionaClassificacao();
  }

  Imc.carregar(this._idImc, this._imc) {
    _classificacao = selecionaClassificacao();
  }

  int get idImc => _idImc;

  double get imc => double.parse(_imc.toStringAsFixed(2));

  String selecionaClassificacao() {
    String info = "Classificação:";
    if (imc < 16) {
      return '$info Magreza grave';
    } else if (imc < 17) {
      return '$info Magreza moderada';
    } else if (imc < 18.5) {
      return '$info Magreza leve';
    } else if (imc < 25) {
      return '$info Saudavel';
    } else if (imc < 30) {
      return '$info Sobrepeso';
    } else if (imc < 35) {
      return '$info Obesidade grau I';
    } else if (imc < 40) {
      return '$info Obesidade grau II (severa)';
    } else {
      return '$info Obesidade grau III (morbida)';
    }
  }

  String get classificacao => _classificacao;
}
