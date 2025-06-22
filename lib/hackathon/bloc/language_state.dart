part of 'language_bloc.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class SelectedLanguageState extends LanguageState {
  final String selectedLang;

  SelectedLanguageState({required this.selectedLang});
}
