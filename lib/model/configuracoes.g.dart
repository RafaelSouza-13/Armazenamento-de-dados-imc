// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'configuracoes.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ConfiguracoesAdapter extends TypeAdapter<Configuracoes> {
  @override
  final int typeId = 0;

  @override
  Configuracoes read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Configuracoes(
      fields[0] as String,
      fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Configuracoes obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._nome)
      ..writeByte(1)
      ..write(obj._altura);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConfiguracoesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
