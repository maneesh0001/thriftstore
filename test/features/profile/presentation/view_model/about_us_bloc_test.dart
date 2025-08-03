import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:thrift_store/features/profile/presentation/view_model/about_us_bloc.dart';
import 'package:thrift_store/features/profile/presentation/view_model/about_us_event.dart';
import 'package:thrift_store/features/profile/presentation/view_model/about_us_state.dart';

void main() {
  group('AboutBloc Tests', () {
    late AboutBloc aboutBloc;

    setUp(() {
      aboutBloc = AboutBloc();
    });

    tearDown(() {
      aboutBloc.close();
    });

    test('initial state is AboutInitial', () {
      expect(aboutBloc.state, AboutInitial());
    });

  blocTest<AboutBloc, AboutState>(
  'emits [AboutLoading, AboutLoaded] when LoadAboutContent is added',
  build: () => AboutBloc(),
  act: (bloc) => bloc.add(LoadAboutContent()),
  wait: const Duration(seconds: 1),
  expect: () => [
    AboutLoading(),
    const AboutLoaded(
      aboutText: "Emirates thrift store is a luxury  store, offering an exclusive collection...",
      missionText: "Our mission is to , providing a luxurious experience...",
      valuesText: "At the heart of  thrift is a dedication to quality and customer satisfaction.",
    ),
  ],
);



    blocTest<AboutBlocWithError, AboutState>(
      'emits [AboutLoading, AboutError] when LoadAboutContent is added and error occurs',
      build: () => AboutBlocWithError(),
      act: (bloc) => bloc.add(LoadAboutContent()),
      wait: const Duration(seconds: 1),
      expect: () => [
        AboutLoading(),
        const AboutError("Failed to load about content."),
      ],
    );
  });
}

// Separate Bloc to simulate error state without extending AboutBloc
class AboutBlocWithError extends Bloc<AboutEvent, AboutState> {
  AboutBlocWithError() : super(AboutInitial()) {
    on<LoadAboutContent>(_onLoadAboutContentWithError);
  }

  Future<void> _onLoadAboutContentWithError(
      LoadAboutContent event, Emitter<AboutState> emit) async {
    emit(AboutLoading());
    await Future.delayed(const Duration(seconds: 1));
    emit(const AboutError("Failed to load about content."));
  }
}
