import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:state_management/data/api/characters_api.dart';
import 'package:state_management/data/model/characters.dart';
import 'package:state_management/data/repository/characters_repository.dart';
import 'package:state_management/helpers/constants/strings.dart';
import 'package:state_management/logic/cubit/characters_cubit.dart';
import 'package:state_management/presention/screens/character_detail_screen.dart';
import 'package:state_management/presention/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit chartactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(charactersApi: CharactersApi());
    chartactersCubit = CharactersCubit(charactersRepository);
  }
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charatersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => chartactersCubit,
            child: const CharactersScreen(),
          ),
        );
      case characterDetailScreen:
        final selectedCharacter = settings.arguments as CharactersModel;

        return MaterialPageRoute(
          builder: (_) =>
              CharacterDetailScreen(selectedCharacter: selectedCharacter),
        );

      default:
        return MaterialPageRoute(builder: (_) => const CharactersScreen());
    }
  }
}
