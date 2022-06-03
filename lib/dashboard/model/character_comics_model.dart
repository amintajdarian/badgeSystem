import 'package:hive/hive.dart';

part 'character_comics_model.g.dart';

@HiveType(typeId: 0)
class CharacterComicsModel {
  @HiveField(1)
  final String name;

  @HiveField(2)
  final int badge;

  CharacterComicsModel({required this.name, required this.badge});
}
