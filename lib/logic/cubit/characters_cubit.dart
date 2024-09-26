import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:state_management/data/model/characters.dart';
import 'package:state_management/data/repository/characters_repository.dart';
part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<CharactersModel> chartacters = []; 
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  // Make this function asynchronous
  Future<void> getAllCharacters() async {
    try {
      final fetchedCharacters = await charactersRepository.getAllCharacters();
      chartacters = fetchedCharacters
          .cast<CharactersModel>(); // Assign the data to chartacters
      emit(ChartactersLoaded(chartacters)); // Emit the loaded state
    } catch (error) {
      // Handle any errors
      // emit(CharactersError("Failed to load characters: $error"));
    }
  }
}
