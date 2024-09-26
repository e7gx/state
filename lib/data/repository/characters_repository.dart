import 'package:state_management/data/api/characters_api.dart';
import 'package:state_management/data/model/characters.dart';

class CharactersRepository {
  final CharactersApi charactersApi;

  CharactersRepository({required this.charactersApi});

  /// Fetches all characters from the API and converts them to a list of `Characters` objects.
  ///
  /// This function makes an asynchronous call to the `charactersApi` to retrieve all characters.
  /// It then maps each character JSON to a `Characters` object and returns a list of these objects.
  ///
  /// Returns:
  ///   A `Future` that completes with a `List` of `Characters` objects.
  Future<List<CharactersModel>> getAllCharacters() async {
    final characters = await charactersApi.getAllCharacters();
    //! print("characters this is a test for the getAllCharacters func in  CharactersRepository class: $characters");
    return characters
        .map((character) => CharactersModel.fromJson(character))
        .toList();
  }
}
