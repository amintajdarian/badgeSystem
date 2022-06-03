import 'package:badge_system/dashboard/model/character_comics_model.dart';
import 'package:hive/hive.dart';

class BadgeDatabase {
  final String _boxName = "characters";
  Future<Box<CharacterComicsModel>> noteBox() async {
    var box = await Hive.openBox<CharacterComicsModel>(_boxName);
    return box;
  }

  Future<void> addCharacter(CharacterComicsModel character) async {
    var box = await noteBox();
    await box.put(character.name, character);
  }

  Future<void> updateCharacter(int index, CharacterComicsModel character) async {
    var box = await noteBox();
    await box.putAt(index, character);
  }

  Future<void> deleteCharacter(int index) async {
    var box = await noteBox();
    await box.deleteAt(index);
  }

  Future<List<CharacterComicsModel>> getCharacters() async {
    var box = await noteBox();
    var data = box.values.toList();
    if (data.isEmpty) {
      await addCharacter(CharacterComicsModel(badge: 0, name: "Batman/girl"));
      await addCharacter(CharacterComicsModel(badge: 0, name: "Spiderman/girl"));
      await addCharacter(CharacterComicsModel(badge: 0, name: "Sherlock"));
      await addCharacter(CharacterComicsModel(badge: 0, name: "Joker"));
      await addCharacter(CharacterComicsModel(badge: 0, name: " Ironman/girl"));
    }
    return box.values.toList();
  }
}
