part of 'show_menu_bloc.dart';

@immutable
sealed class ShowMenuState {}

final class ShowMenuInitial extends ShowMenuState {}

class ToggleInfoState extends ShowMenuState {
  final bool value;

  ToggleInfoState({required this.value});
}
