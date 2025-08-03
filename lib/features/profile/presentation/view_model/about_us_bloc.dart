import 'package:flutter_bloc/flutter_bloc.dart';

import 'about_us_event.dart';
import 'about_us_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutInitial()) {
    on<LoadAboutContent>(_onLoadAboutContent);
  }

  Future<void> _onLoadAboutContent(
      LoadAboutContent event, Emitter<AboutState> emit) async {
    emit(AboutLoading());
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    try {
      emit(AboutLoaded(
        aboutText:
            "Emirates thrift store is a luxury  store, offering an exclusive collection...",
        missionText:
            "Our mission is to , providing a luxurious experience...",
        valuesText:
            "At the heart of  thrift is a dedication to quality and customer satisfaction.",
      ));
    } catch (e) {
      emit(AboutError("Failed to load about content."));
    }
  }
}