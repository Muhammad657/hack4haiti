part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

final class SelectLangEvent extends LanguageEvent {
  final String selectedLang;

  SelectLangEvent({required this.selectedLang});
}
