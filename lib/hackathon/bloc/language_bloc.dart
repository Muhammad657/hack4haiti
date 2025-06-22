import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<SelectLangEvent>((event, emit) {
      emit(SelectedLanguageState(selectedLang: event.selectedLang));
    });
  }
}
