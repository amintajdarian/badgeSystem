// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_comics_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CharacterComicsModelAdapter extends TypeAdapter<CharacterComicsModel> {
  @override
  final int typeId = 0;

  @override
  CharacterComicsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CharacterComicsModel(
      name: fields[1] as String,
      badge: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CharacterComicsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.badge);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CharacterComicsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
