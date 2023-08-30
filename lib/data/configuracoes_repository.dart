import 'package:hive/hive.dart';
import '../model/configuracoes.dart';

class ConfiguracoesRepository {
  static late Box _box;
  static const String _chave = 'configuracoesUsuario';
  // static const String _chaveNome = 'nomeUsuario';
  // static const String _chaveAltura = 'altura';

  ConfiguracoesRepository._criar();

  static Future<ConfiguracoesRepository> carregar() async {
    if (Hive.isBoxOpen(_chave)) {
      _box = Hive.box(_chave);
    } else {
      _box = await Hive.openBox(_chave);
    }
    return ConfiguracoesRepository._criar();
  }

  // void salvar(Configuracoes configuracoes) {
  //   _box.put(_chave, <String, dynamic>{
  //     _chaveNome: configuracoes.nome,
  //     _chaveAltura: configuracoes.altura,
  //   });
  // }

  void salvar(Configuracoes configuracoes) {
    _box.put(_chave, configuracoes);
  }

  Future<Configuracoes> obterDados() async {
    var configuracoes = await _box.get(_chave);
    if (configuracoes == null) {
      return Configuracoes.vazio();
    } else {
      return configuracoes;
    }
  }

  void reiniciar() {
    var configuracoes = Configuracoes.vazio();
    salvar(configuracoes);
  }
}
