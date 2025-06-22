part of 'show_menu_bloc.dart';

@immutable
sealed class ShowMenuEvent {}

class ClickAddEvent extends ShowMenuEvent {
  final bool value;

  ClickAddEvent({required this.value});
}
