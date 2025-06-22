import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_menu_event.dart';
part 'show_menu_state.dart';

class ShowMenuBloc extends Bloc<ShowMenuEvent, ShowMenuState> {
  ShowMenuBloc() : super(ShowMenuInitial()) {
    on<ClickAddEvent>((event, emit) {
      emit(ToggleInfoState(value: event.value));
    });
  }
}
