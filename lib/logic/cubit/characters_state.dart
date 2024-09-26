part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

class CharactersErrorCase extends CharactersState {
  final String message;
  CharactersErrorCase(this.message);
}

class ChartactersLoaded extends CharactersState {
  final List<CharactersModel> chartacters;
  ChartactersLoaded(this.chartacters);
}
